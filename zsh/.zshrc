
if (( $+commands[arch] )); then
	# amd64 mac with homebrew (probably)
	# Add path based on current (emulated) arch
	ARCH=$(arch)
	ORIGINAL_PATH=$PATH

	if [ $ARCH = 'i386' ]; then
		# i386 should not mean x86_64 and I don't know why apple pretends it does
		ARCH=x86_64
		export HOMEBREW_PREFIX=/usr/local
	else
		export HOMEBREW_PREFIX=/opt/homebrew
	fi
	path=(
		$HOMEBREW_PREFIX/{bin,sbin}
		$path
	)
else
	# Intel mac or Linux. Add /usr/local
	path=(
		/usr/local/{bin,sbin}
		$path
	)
fi

x86() { arch -arch x86_64 -e "PATH=$ORIGINAL_PATH" zsh }
arm() { arch -arch arm64  -e "PATH=$ORIGINAL_PATH" zsh }


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
f(){ ag --nocolor -l -g "$1" "${2:-.}" }

tmrun() { tmux split-window -c `pwd` -l 10 "zsh -ic \"$@;read\"" && tmux last-pane }
tmgem() { tmux new-window -c `bundle show $1` -n "$1" }

# Expands symlinks on cd
setopt CHASE_LINKS

PS1='
%F{135}%n%f@%F{166}%m%f:%F{118}%~%f ${ARCH} ${vcs_info_msg_0_} [${RUBY_ENGINE} ${RUBY_VERSION}]
$ '

export GOPATH=~/go

export QUOTING_STYLE=literal

[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
