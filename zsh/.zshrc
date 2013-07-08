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
#unalias rm
#unalias mv

alias mplayer=mpv
alias mmv='noglob zmv -W'
alias t='task'
alias beet='python2 =beet'
alias ls="ls --group-directories-first --color=auto -v"
alias l="ls"

# As of nokogiri 1.6, it will compile its own version of libxml2 and libxslt.
# While this is convenient, it is slower, and uses about 100MB for each
# install. For a development machine (many gemsets, bundle install often) this
# is a better default.
export NOKOGIRI_USE_SYSTEM_LIBRARIES=1

# Don't garbage collect as often. Sacrifice some ram.
export RUBY_GC_MALLOC_LIMIT=80000000

PS1='
%F{135}%n%f@%F{166}%m%f:%F{118}%~%f ${vcs_info_msg_0_}
$ '
