
for config_file ($HOME/.zsh/*.zsh); do
  source $config_file
done

alias mplayer=mpv
alias mmv='noglob zmv -W'
alias t=task
alias beet='python2 =beet'
alias ls="ls --group-directories-first --color=auto -v"
alias l="ls"
alias json="jq ."
alias xml="xmllint --format -"
f(){ ag --nocolor -l -g "$1" "${2:-.}" }

tmrun() { tmux split-window -c `pwd` -l 10 "zsh -ic \"$@;read\"" && tmux last-pane }
tmgem() { tmux new-window -c `bundle show $1` -n "$1" }

# Expands symlinks on cd
setopt CHASE_LINKS

PS1='
%F{135}%n%f@%F{166}%m%f:%F{118}%~%f ${vcs_info_msg_0_} [${RUBY_ENGINE} ${RUBY_VERSION}]
$ '

export GOPATH=~/go

[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
