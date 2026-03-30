#!/bin/zsh
# curl -fsSL https://raw.githubusercontent.com/jhawthorn/dotfiles/main/.dotfiles/setup.sh | zsh
set -e

DOTFILES_GIT="$HOME/.dotfiles.git"
DOTFILES_REPO="https://github.com/jhawthorn/dotfiles.git"

dotfiles() {
	git --git-dir="$DOTFILES_GIT" --work-tree="$HOME" "$@"
}

if [ -d "$DOTFILES_GIT" ]; then
	echo "Dotfiles already cloned, pulling latest..."
	dotfiles pull --rebase --autostash
else
	echo "Cloning dotfiles..."
	git clone --bare "$DOTFILES_REPO" "$DOTFILES_GIT"

	# Don't show all of $HOME as untracked
	dotfiles config status.showUntrackedFiles no

	# Checkout files into $HOME, skipping any that already exist
	dotfiles ls-tree -r --name-only HEAD | while read -r file; do
		if [ ! -e "$HOME/$file" ]; then
			dotfiles checkout HEAD -- "$file"
		else
			echo "Skipping existing file: $file"
		fi
	done
fi

echo "Updating submodules..."
dotfiles submodule update --init --recursive

# Neovim plugin/treesitter setup
if command -v nvim &>/dev/null; then
	echo "Setting up neovim..."
	"$HOME/bin/dotfiles_setup.sh"
fi

echo "Done!"
