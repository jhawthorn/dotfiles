#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
unalias rm
unalias mv

alias mplayer=mpv
alias mmv='noglob zmv -W'
alias t=task
alias beet='python2 =beet'
alias ls="ls --group-directories-first --color=auto -v"
alias l="ls"
alias json="python -mjson.tool"
alias xml="xmllint --format -"
alias git="hub"
compdef hub=git
alias b="git branch | cut -c 3- | fzy | xargs git checkout"

v(){
	if [[ -z $1 ]]; then
		vim $(ag -l -g '' | fzy)
	else
		vim $*
	fi
}
compdef v=vim

alias f="ag --nocolor -l -g ''"

tmrun() { tmux split-window -c `pwd` -l 10 "zsh -ic \"$@;read\"" && tmux last-pane }
tmgem() { tmux new-window -c `bundle show $1` -n "$1" }

# As of nokogiri 1.6, it will compile its own version of libxml2 and libxslt.
# While this is convenient, it is slower, and uses about 100MB for each
# install. For a development machine (many gemsets, bundle install often) this
# is a better default.
export NOKOGIRI_USE_SYSTEM_LIBRARIES=1

# Don't garbage collect as often. Sacrifice some ram.
export RUBY_GC_MALLOC_LIMIT=80000000

# Expands symlinks on cd
setopt CHASE_LINKS

# I mash this by accident far more often than intending too
# I can live without it
stty -ixon -ixoff

PS1='
%F{135}%n%f@%F{166}%m%f:%F{118}%~%f ${vcs_info_msg_0_} [${RUBY_ENGINE} ${RUBY_VERSION}]
$ '

export GOPATH=~/go

source $HOME/.local/share/chruby/chruby.sh
source $HOME/.local/share/chruby/auto.sh
source $HOME/.local/share/bundler-exec/bundler-exec.sh

# Read ~/.ruby-version to determine version
chruby_auto


unsetopt flowcontrol
function insert-selecta-path-in-command-line() {
    local selected_path
    echo
    selected_path=$(ag . -l -g '' | fzy) || return
    eval 'LBUFFER="$LBUFFER$selected_path"'
    zle reset-prompt
}
zle -N insert-selecta-path-in-command-line
bindkey "^S" "insert-selecta-path-in-command-line"

