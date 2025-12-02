if [[ -z "$BROWSER" && "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
export MANPAGER="nvim +Man!"
export LESS='-F -g -i -M -R -S -w -X -z-4'

export TZ=America/Vancouver

export NPM_PACKAGES="$HOME/.npm-packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

if [[ -z "$LANG" ]]; then
  eval "$(locale)"
fi

XDG_DATA_HOME=$HOME/.local/share
XDG_CONFIG_HOME=$HOME/.config

typeset -gU cdpath fpath mailpath path

path=(
  $HOME/bin
  $HOME/go/bin
  $NPM_PACKAGES/bin
  $path
)
