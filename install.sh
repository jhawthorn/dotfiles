#!/bin/zsh

cd "$( dirname "$0" )"

git submodule update --init --recursive

zsh    bin/install.sh
zsh    git/install.sh
zsh   mail/install.sh
zsh  music/install.sh
zsh   misc/install.sh
zsh   ruby/install.sh
zsh   tmux/install.sh
zsh    vim/install.sh
zsh      x/install.sh
zsh    zsh/install.sh
ln -sfn "$(pwd)/terminfo" "$HOME/.terminfo"

if [[ -n "$CODESPACES" ]]; then
	apt-get install -y fzy fd-find linux-perf
	ln -s $(which fdfind) /usr/local/bin/fd
	ln -s /usr/bin/perf_* /usr/local/bin/perf
	chsh -s /bin/zsh
fi
