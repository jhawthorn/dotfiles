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
alias t='task'
alias beet='python2 =beet'
alias ls="ls --group-directories-first --color=auto -v"

export RUBY_GC_MALLOC_LIMIT=80000000

