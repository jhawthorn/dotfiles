# Inlined, zsh-only chruby. Never runs ruby itself: only RUBY_ROOT, RUBYOPT
# and PATH are managed.
#
# Every function starts with `emulate -L zsh` so it behaves the same whatever
# options the interactive shell has set. Functions that need EXTENDED_GLOB
# enable it for themselves.
typeset -T GEM_PATH gem_path

chruby_reload() {
	emulate -L zsh
	typeset -ga RUBIES
	RUBIES=(/opt/rubies/*(N-/) ~/.rubies/*(N-/))
}
chruby_reload

chruby_reset() {
	emulate -L zsh
	[[ -z $RUBY_ROOT ]] && return

	path=(${path:#$RUBY_ROOT/bin})

	if (( UID != 0 )); then
		[[ -n $GEM_HOME ]] && path=(${path:#$GEM_HOME/bin})
		gem_path=(${gem_path:#$GEM_HOME})
		unset GEM_HOME
		(( $#gem_path )) || unset GEM_PATH
	fi

	unset RUBY_ROOT RUBYOPT
	rehash
}

chruby_use() {
	emulate -L zsh
	if [[ ! -x $1/bin/ruby ]]; then
		print -u2 "chruby: $1/bin/ruby not executable"
		return 1
	fi

	[[ -n $RUBY_ROOT ]] && chruby_reset

	export RUBY_ROOT=$1 RUBYOPT=$2
	path=($RUBY_ROOT/bin $path)
	rehash
}

chruby() {
	emulate -L zsh
	chruby_reload
	case $1 in
		-h|--help) print "usage: chruby [RUBY|VERSION|system] [RUBYOPT...]" ;;
		system)    chruby_reset ;;
		"")
			local dir
			for dir in $RUBIES; do
				if [[ $dir == $RUBY_ROOT ]]; then
					print " * ${dir:t} $RUBYOPT"
				else
					print "   ${dir:t}"
				fi
			done ;;
		*)
			# Exact name wins, otherwise the last substring match.
			local match=${RUBIES[(r)*/$1]:-${RUBIES[(R)*$1*]}}
			if [[ -z $match ]]; then
				print -u2 "chruby: unknown Ruby: $1"
				return 1
			fi
			shift
			chruby_use $match "$*" ;;
	esac
}

# Switch based on the nearest .ruby-version, walking up from $PWD.
chruby_auto() {
	emulate -L zsh -o extendedglob

	# (../)# matches in every ancestor. Results sort farthest first, since
	# "../" sorts before ".r", so the nearest file is last.
	local -a files=( (../)#.ruby-version(N-.r) )
	local version
	(( $#files )) && read -r version <$files[-1]
	version=${version%$'\r'}

	if [[ -z $version ]]; then
		[[ -n $RUBY_AUTO_VERSION ]] && { chruby_reset; unset RUBY_AUTO_VERSION }
	elif [[ $version != $RUBY_AUTO_VERSION ]]; then
		RUBY_AUTO_VERSION=$version
		chruby $version
	fi
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec chruby_auto

# Read ~/.ruby-version to determine version
chruby_auto

selectgem(){
       if [ -z "$1" ]; then
               bundle show | tr -s ' ' | cut -d ' ' -f 3 | fzy
       else
               echo "$1"
       fi
}

gempath() {
       bundle show $(selectgem $1)
}

tmgem() {
       GEM=$(selectgem "$1")
       tmux new-window -c $(bundle show $GEM) -n "$GEM"
}

gemcd() {
       pushd $(gempath "$1")
}

alias be="bundle exec"
