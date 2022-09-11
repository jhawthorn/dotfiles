
# auto-escape URLs
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# 10ms for key sequences
KEYTIMEOUT=1

# Multi-level undo
bindkey -a u undo
bindkey -a '^R' redo

# delete past the position entering insert mode
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

source ${0:a:h}/../zsh-vi-mode/zsh-vi-mode.plugin.zsh

# irc client like input
# From http://zshwiki.org/home/zle/ircclientlikeinput
down-or-fake-accept-line() {
  if (( HISTNO == HISTCMD )) && [[ "$RBUFFER" != *$'\n'* ]];
  then
    zle fake-accept-line
  fi
  zle .down-line-or-history "$@"
}

