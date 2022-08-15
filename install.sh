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

ln -sfn "$(pwd)" "$HOME/.dotfiles"

if [[ -n "$CODESPACES" ]]; then
	sudo chsh -s /bin/zsh $(whoami)
	sudo apt-get install -y fzy fd-find ripgrep tmux
	sudo ln -s $(which fdfind) /usr/local/bin/fd
	sudo apt-get install -y linux-perf
	sudo ln -s /usr/bin/perf_* /usr/local/bin/perf
fi
