# ~/.zshenv

export EDITOR=vim
export BROWSER="chrome"

# fallbacks for $TERM
case "$TERM" in
	rxvt|rxvt-16color|rxvt-unicode|rxvt-unicode-256color)
		if  [ -f $TERMINFO/r/rxvt-unicode-256color -o -f $TERMINFO/72/rxvt-unicode256color ]; then
			TERM=rxvt-unicode-256color
		elif [ -f $TERMINFO/r/rxvt-256color -o -f $TERMINFO/72/rxvt-256color ]; then
			TERM=rxvt-256color
		elif  [ -f $TERMINFO/r/rxvt-unicode -o -f $TERMINFO/72/rxvt-unicode ]; then
			TERM=rxvt-unicode
		elif [ -f $TERMINFO/r/rxvt-16color -o -f $TERMINFO/72/rxvt-16color ]; then
			TERM=rxvt-16color
		else
			TERM=rxvt
		fi
		;;
	xterm|xterm-256color|xterm-256color)
		if [ -f $TERMINFO/x/xterm-256color -o -f $TERMINFO/78/xterm-256color ]; then
			TERM=xterm-256color
		else
			TERM=xterm
		fi
		;;
esac

