
HISTFILE=~/.zhistory
HISTSIZE=100000
SAVEHIST=$HISTSIZE

setopt INC_APPEND_HISTORY_TIME
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_SPACE

# consider:
# setopt append_history share_history histignorealldups

bindkey "^[OA" history-search-backward
bindkey "^[OB" history-search-forward
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

