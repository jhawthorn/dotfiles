#!/bin/zsh

export DEBIAN_FRONTEND=noninteractive

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
	sudo apt-get install -y linux-tools-common linux-tools-generic

	echo 0 | sudo tee /proc/sys/kernel/kptr_restrict > /dev/null
	echo -1 | sudo tee /proc/sys/kernel/perf_event_paranoid > /dev/null

	curl -sSL https://github.com/neovim/neovim/releases/download/v0.9.4/nvim-linux64.tar.gz | tar xvzp --strip-components=1 -C "$HOME/.local/"
	ln -sf "$HOME/.local/bin/nvim" "$HOME/bin/"

	cat <<-"GITCONFIG" >> "$HOME/.gitconfig.local"
[credential "https://github.com"]
        helper =
        helper = !/usr/bin/gh auth git-credential
[credential "https://gist.github.com"]
        helper =
        helper = !/usr/bin/gh auth git-credential
GITCONFIG
fi

nvim --headless -u ~/.config/nvim/lua/plugins.lua  -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
nvim --headless +'helptags ALL' +':TSUpdateSync ruby c lua rust python markdown make go cpp bash' +qa
