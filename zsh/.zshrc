
if [[ `uname` == "Darwin" ]]; then
    source $HOME/.zsh/os/macos.zsh
fi

# Trying it out....
alias vim="nvim"
export EDITOR=nvim

for config_file ($HOME/.zsh/*.zsh); do
  source $config_file
done

export CLICOLOR=1

alias mplayer=mpv
alias mmv='noglob zmv -W'
alias t=task
alias beet='python2 =beet'
alias ls="ls -F"
alias l="ls"
alias json="jq ."
alias xml="xmllint --format -"
alias shh="echo 🤫"
f(){ ag --nocolor -l -g "$1" "${2:-.}" }

tmrun() { tmux split-window -c `pwd` -l 10 "zsh -ic \"$@;read\"" && tmux last-pane }
tmgem() { tmux new-window -c `bundle show $1` -n "$1" }

# Expands symlinks on cd
setopt CHASE_LINKS

export GOPATH=~/go

export QUOTING_STYLE=literal

[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"

fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure
