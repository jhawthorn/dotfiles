# I mash this by accident far more often than intending too
# I can live without it
stty -ixon -ixoff

function insert-fzy-path-in-command-line() {
        local selected_path
        echo # Run fzy underneath the current prompt
        selected_path=$(ag . -l -g '' | fzy) || return
        LBUFFER="$LBUFFER${(q)selected_path} " # ${(q)VAR} shell-escapes the string
        zle reset-prompt
}
zle -N insert-fzy-path-in-command-line

unsetopt flowcontrol # By default, ^S freezes terminal output, only needed if keybinding is ^S
bindkey "^S" "insert-fzy-path-in-command-line"

alias b="git branch | cut -c 3- | fzy | xargs git checkout"

v(){
	if [[ -z $1 ]]; then
		FILE=$(fd | fzy) && vim "$FILE"
	else
		vim $*
	fi
}

fcd(){
	cd "$(find -type d | fzy)"
}

compdef v=vim

