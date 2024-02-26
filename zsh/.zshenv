#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   John Hawthorn <john.hawthorn@gmail.com>
#

#
# Browser
#

#
# Editors
#

export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
export MANPAGER='nvim +Man!'

export TERMINFO="$HOME/.terminfo"
export MOSH_TITLE_NOPREFIX=1
export MPD_HOST="$HOME/.mpd/socket"

export TZ=America/Vancouver

export NPM_PACKAGES="$HOME/.npm-packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

#
# Language
#

if [[ -z "$LANG" ]]; then
  eval "$(locale)"
fi

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
if (( $+commands[lesspipe.sh] )); then
  export LESSOPEN='| /usr/bin/env lesspipe.sh %s 2>&-'
fi

#
# Paths
#

typeset -gU cdpath fpath mailpath manpath path
typeset -gUT INFOPATH infopath

# Set the the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that info searches for manuals.
infopath=(
  /usr/local/share/info
  /usr/share/info
  $infopath
)

# Set the list of directories that man searches for manuals.
manpath=(
  /usr/local/share/man
  /usr/share/man
  $manpath
)

for path_file in /etc/manpaths.d/*(.N); do
  manpath+=($(<$path_file))
done
unset path_file

# Set the list of directories that Zsh searches for programs.
path=(
  $HOME/bin
  $HOME/go/bin
  $NPM_PACKAGES/bin
  /Applications/Postgres.app/Contents/Versions/latest/bin
  /usr/local/opt/mysql@5.7/bin
  /usr/local/{bin,sbin}
  /usr/{bin,sbin}
  /{bin,sbin}
  $path
)

for path_file in /etc/paths.d/*(.N); do
  path+=($(<$path_file))
done
unset path_file

#
# Temporary Files
#

if [[ -d "$TMPDIR" ]]; then
  export TMPPREFIX="${TMPDIR%/}/zsh"
  if [[ ! -d "$TMPPREFIX" ]]; then
    mkdir -p "$TMPPREFIX"
  fi
fi

XDG_DATA_HOME=$HOME/.local/share
XDG_CONFIG_HOME=$HOME/.config

[ -f "$HOME/.zshenv.local" ] && source "$HOME/.zshenv.local"

