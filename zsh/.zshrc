# Set the path to Oh My Zsh.
export OMZ="$HOME/.oh-my-zsh"

# Set the key mapping style to 'emacs' or 'vi'.
zstyle ':omz:module:editor' keymap 'vi'

# Auto convert .... to ../..
zstyle ':omz:module:editor' dot-expansion 'yes'

# Set case-sensitivity for completion, history lookup, etc.
zstyle ':omz:*:*' case-sensitive 'yes'

# Color output (auto set to 'no' on dumb terminals).
zstyle ':omz:*:*' color 'yes'

# Auto set the tab and window titles.
zstyle ':omz:module:terminal' auto-title 'yes'

# Set the Zsh modules to load (man zshmodules).
# zstyle ':omz:load' zmodule 'attr' 'stat'

# Set the Zsh functions to load (man zshcontrib).
zstyle ':omz:load' zfunction 'zargs' 'zmv'

# Set the Oh My Zsh modules to load (browse modules).
zstyle ':omz:load' omodule 'environment' 'terminal' 'editor' 'completion' \
  'history' 'directory' 'spectrum' 'alias' 'prompt'

# Set the prompt theme to load.
# Setting it to 'random' loads a random theme.
# Auto set to 'off' on dumb terminals.
zstyle ':omz:module:prompt' theme 'steeef'

# This will make you shout: OH MY ZSHELL!
source "$OMZ/init.zsh"

# Customize to your needs...

. "$HOME/.rvm/scripts/rvm"

function rails() {
	if [ -e "script/rails" ]; then
		ruby script/rails $@
	else
		=rails $@
	fi
}

function scratch() {
	local cur_dir="$HOME/scratch"
	local new_dir=$(mktemp -d /var/tmp/scratch-$(date +%F)-XXXXX)
	ln -nfs $new_dir $cur_dir
	cd $cur_dir
}

unsetopt SHARE_HISTORY

# don't tell me how to type. it sickens me
unsetopt correct
unsetopt correctall
unalias rm

# report time for commands > 10 seconds
export REPORTTIME=10

# history search
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

# for mplayer script
alias tv="export TV=1"

alias nyan="nyancat"

alias mmv='noglob zmv -W'

export PATH=$HOME/bin:$PATH
