
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

