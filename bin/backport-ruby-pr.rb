#!/usr/bin/env ruby
# Open a backport pull request for a merged ruby/ruby PR.
#
#   backport-pr.rb -t 4.0 https://github.com/ruby/ruby/pull/19313
#   backport-pr.rb -t 3.4 19313
#
# It cherry-picks (-x) the commits the PR landed on master onto ruby_X_Y,
# pushes the result to a branch on your fork, and opens a PR against
# ruby/ruby's ruby_X_Y with `gh`. The work happens in a throwaway git worktree
# under .git/backport-pr/ that is always removed, so your own checkout is left
# alone. If the cherry-pick conflicts it gives up; backport that one by hand.
#
# Requires git and an authenticated gh. Run it from a ruby checkout.

require 'optparse'
require 'json'
require 'open3'
require 'shellwords'
require 'fileutils'

UPSTREAM_SLUG = 'ruby/ruby'
UPSTREAM_URL = "https://github.com/#{UPSTREAM_SLUG}.git"
DEFAULT_BRANCH = 'master'

version = nil
push_remote = 'origin'
dry_run = false
draft = false

opts = OptionParser.new do |o|
  o.banner = "usage: #{$0} -t VERSION [options] PR_URL_OR_NUMBER"
  o.on('-t', '--target=VERSION', /\A\d+\.\d+\z/, "Ruby version to backport to (required, e.g. 4.0)") {|v| version = v}
  o.on('-r', '--remote=NAME', "remote to push the branch to (default: #{push_remote})") {|v| push_remote = v}
  o.on('--draft', 'open the PR as a draft') {draft = true}
  o.on('-n', '--dry-run', 'check that it cherry-picks cleanly, but do not push or open the PR') {dry_run = true}
end
opts.parse!(ARGV)

def run(*cmd)
  puts "+ #{cmd.shelljoin}"
  system(*cmd) or abort "command failed: #{cmd.shelljoin}"
end

def capture(*cmd)
  out, err, st = Open3.capture3(*cmd)
  abort "command failed: #{cmd.shelljoin}\n#{err}" unless st.success?
  out.strip
end

pr_arg = ARGV.shift or (puts opts.help; exit 1)
version or abort "no target version given; pass -t VERSION (e.g. -t 4.0)"

branch_name = "ruby_#{version.tr('.', '_')}"
base_ref = "refs/remotes/backport-pr/#{branch_name}"
master_ref = "refs/remotes/backport-pr/#{DEFAULT_BRANCH}"

pr_number = pr_arg[%r{\A(?:https://github\.com/#{UPSTREAM_SLUG}/pull/)?(\d+)(?:[/?#].*)?\z}, 1] or
  abort "expected a #{UPSTREAM_SLUG} PR URL or number, got #{pr_arg.inspect}"

pr = JSON.parse(capture('gh', 'pr', 'view', pr_number, '--repo', UPSTREAM_SLUG, '--json',
                        'title,body,state,url,mergeCommit,commits'))
abort "#{pr['url']} is #{pr['state'].downcase}, not merged" unless pr['state'] == 'MERGED'

tickets = (pr['commits'].map {|c| c['messageHeadline'] + "\n" + c['messageBody']} + [pr['title'], pr['body']])
  .join("\n").scan(/\[(?:Bug|Feature|Misc) #(\d+)\]/i).flatten.uniq

title = pr['title'].sub(/ \(#\d+\)\z/, '').sub(/\A(?:\s*\[(?:Bug|Feature|Misc) #\d+\])+\s*/i, '')
title = "[#{version}]#{tickets.map {|t| "[Backport ##{t}]"}.join} #{title}"
pr_branch = "#{branch_name}-pr-#{pr_number}"

run 'git', 'fetch', '--quiet', UPSTREAM_URL,
    "+refs/heads/#{DEFAULT_BRANCH}:#{master_ref}", "+refs/heads/#{branch_name}:#{base_ref}"

merge = pr['mergeCommit']['oid']
parents = capture('git', 'rev-list', '--parents', '-n1', merge).split.drop(1)
nonmerge_subjects = pr['commits'].map {|c| c['messageHeadline']}.reject {|s| s.start_with?('Merge ')}

# How the PR landed on master decides which commits to pick:
#  - merge commit: the commits reachable from it but not from its first parent
#  - rebase: the same subjects, ending at the merge commit
#  - squash: the merge commit alone
commits =
  if parents.size > 1
    capture('git', 'rev-list', '--reverse', '--no-merges', "#{parents[0]}..#{merge}").split
  elsif nonmerge_subjects.include?(capture('git', 'show', '-s', '--format=%s', merge))
    walked = capture('git', 'rev-list', '--first-parent', '--no-merges', "-n#{nonmerge_subjects.size}", merge).split
    walked.select {|c| nonmerge_subjects.include?(capture('git', 'show', '-s', '--format=%s', c))}.reverse
  else
    [merge]
  end
abort 'could not work out which commits to backport' if commits.empty?

puts "Backporting #{commits.size} commit(s) from #{pr['url']} to #{branch_name}:"
commits.each {|c| puts "  " + capture('git', 'show', '-s', '--format=%h %s', c)}

body = +"Backport of #{pr['url']}"
tickets.each {|t| body << " ([Bug ##{t}](https://bugs.ruby-lang.org/issues/#{t}))"} if tickets.size == 1
body << " to `#{branch_name}`.\n\nThis is `git cherry-pick -x` of the merged commit(s)."
body << "\n\nRelated tickets: #{tickets.map {|t| "https://bugs.ruby-lang.org/issues/#{t}"}.join(', ')}" if tickets.size > 1

# A detached worktree under .git (not /tmp), so there is no local branch to clean up.
git_dir = capture('git', 'rev-parse', '--path-format=absolute', '--git-common-dir')
wt = File.join(git_dir, 'backport-pr', pr_branch)
FileUtils.rm_rf(wt) # left over from an interrupted run
run 'git', 'worktree', 'prune'
run 'git', 'worktree', 'add', '--detach', wt, base_ref

begin
  unless system('git', '-C', wt, 'cherry-pick', '-x', *commits)
    system('git', '-C', wt, 'status', '--short')
    abort "\ncherry-pick conflicts on #{branch_name}; backport this one by hand"
  end

  if dry_run
    puts "\n--dry-run: applies cleanly. Would open:\n  #{title}"
    exit
  end

  owner = capture('git', 'remote', 'get-url', push_remote)[%r{github\.com[:/]([^/]+)/}, 1] or
    abort "can't tell the GitHub owner of remote #{push_remote}"
  run 'git', '-C', wt, 'push', push_remote, "HEAD:refs/heads/#{pr_branch}"
  cmd = ['gh', 'pr', 'create', '--repo', UPSTREAM_SLUG, '--base', branch_name,
         '--head', "#{owner}:#{pr_branch}", '--title', title, '--body', body]
  cmd << '--draft' if draft
  run(*cmd)
ensure
  Dir.chdir(git_dir) {system 'git', 'worktree', 'remove', '--force', wt}
end
