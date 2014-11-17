# I mash this by accident far more often than intending too
# I can live without it
stty -ixon -ixoff

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

alias b="git branch | cut -c 3- | fzy | xargs git checkout"

v(){
	if [[ -z $1 ]]; then
		vim $(ag -l -g '' | fzy)
	else
		vim $*
	fi
}

fcd(){
	cd "$(find -type d | fzy)"
}

compdef v=vim

