cd "$( dirname "$0" )"
ln -sf "$(pwd)/.vimrc" "$HOME/.vimrc"

mkdir -p "$HOME/.vim/bundle"
rm -Rf "$HOME/.vim/bundle/vundle"
git clone https://github.com/gmarik/vundle.git "$HOME/.vim/bundle/vundle"
vim +BundleInstall +qa

