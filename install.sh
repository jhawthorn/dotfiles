#!/bin/zsh

export DEBIAN_FRONTEND=noninteractive

cd "$( dirname "$0" )"

git submodule update --init --recursive

zsh aerospace/install.sh
zsh    bin/install.sh
zsh    git/install.sh
zsh   mail/install.sh
zsh  music/install.sh
zsh   misc/install.sh
zsh   ruby/install.sh
zsh   tmux/install.sh
zsh    vim/install.sh
zsh   nvim/install.sh
zsh      x/install.sh
zsh    zsh/install.sh
ln -sfn "$(pwd)/terminfo" "$HOME/.terminfo"

ln -sfn "$(pwd)" "$HOME/.dotfiles"

export PATH="$HOME/bin:$PATH"
nvim --headless "+Lazy! sync" +qa
nvim --headless +'helptags ALL' +':TSUpdateSync ruby c lua rust python markdown make go cpp bash' +qa
