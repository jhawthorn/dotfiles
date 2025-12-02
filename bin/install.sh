#!/bin/zsh

mkdir -p "$HOME/bin"
cd `dirname "$0"`

files=(
chrome
git-recent
inspect
install_ruby
rline
roll
update_dotfiles
)

for name in $files; do
	ln -sf "$(pwd)/$name" "$HOME/bin/$name"
done
