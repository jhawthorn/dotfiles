#!/usr/bin/env ruby

require "minitest"
require "minitest/autorun"
require "ttytest"

require "socket"

class FzyTest < Minitest::Test
  def test_shell
    @tty = new_terminal
    @tty.assert_matches <<TERM

#{expected_ps1}
$
TERM
  end

  def test_vim
    @tty = new_terminal
    @tty.send_keys("vim\n")
    @tty.assert_matches <<TERM
  1
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
[No Name]                                                     0,0-1          All
TERM
  end

  private

  def expected_ps1
    hostname = Socket.gethostname.split(".")[0]
    user = ENV["USER"]
    pwd = "/"
    ruby = "#{ENV["RUBY_ENGINE"]} #{ENV["RUBY_VERSION"]}"

    "#{user}@#{hostname}:#{pwd}  [#{ruby}]"
  end

  def new_terminal
    Dir.chdir("/") do
      TTYtest.new_terminal("/bin/zsh -l")
    end
  end
end
