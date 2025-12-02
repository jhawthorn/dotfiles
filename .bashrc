#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load chruby
source "$HOME/.local/share/chruby/chruby.sh"
source "$HOME/.local/share/chruby/auto.sh"

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
