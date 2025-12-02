# I mash this by accident far more often than intending too
# I can live without it
stty -ixon -ixoff <$TTY >$TTY

function insert-fzy-path-in-command-line() {
        local selected_path
        echo # Run fzy underneath the current prompt
        selected_path=$(fd --type f | fzy) || return
        LBUFFER="$LBUFFER${(q)selected_path} " # ${(q)VAR} shell-escapes the string
        zle reset-prompt
}
zle -N insert-fzy-path-in-command-line

unsetopt flowcontrol # By default, ^S freezes terminal output, only needed if keybinding is ^S
bindkey "^S" "insert-fzy-path-in-command-line"

alias b="git branch | cut -c 3- | fzy | xargs git checkout"

alias v="nvim -c ':lua vim.defer_fn(function() vim.cmd(\":Telescope find_files\") end, 100)'"

fcd(){
	cd "$(find -type d | fzy)"
}

compdef v=vim

