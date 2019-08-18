cd "$( dirname "$0" )"

mkdir -p "$HOME/.vim"

rm -Rf "$HOME/.vim/bundle"
rm -Rf "$HOME/.vim/pack"

ln -sf "$(pwd)/.vimrc" "$HOME/.vimrc"
ln -sf "$(pwd)/pack" "$HOME/.vim/pack"
