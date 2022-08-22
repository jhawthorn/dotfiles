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
	sudo ln -sf $(which fdfind) /usr/local/bin/fd
	sudo apt-get install -y linux-perf
	sudo ln -sf /usr/bin/perf_* /usr/local/bin/perf

	echo 0 | sudo tee /proc/sys/kernel/kptr_restrict > /dev/null
	echo -1 | sudo tee /proc/sys/kernel/perf_event_paranoid > /dev/null

	curl -sSL https://github.com/neovim/neovim/releases/download/v0.7.2/nvim-linux64.tar.gz | tar xvzp --strip-components=1 -C "$HOME/.local/"
	ln -sf "$HOME/.local/bin/nvim" "$HOME/bin/"
fi

nvim --headless +'helptags ALL' +':TSUpdateSync ruby c lua rust python markdown make go cpp bash' +qa
