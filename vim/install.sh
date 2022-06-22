cd "$( dirname "$0" )"

mkdir -p "$HOME/.vim"
mkdir -p "$HOME/.config"

rm -Rf "$HOME/.vim/bundle"
rm -Rf "$HOME/.vim/pack"
rm -Rf "$HOME/.config/nvim"

ln -sf "$(pwd)/.vimrc" "$HOME/.vimrc"
ln -sf "$(pwd)/pack" "$HOME/.vim/pack"
ln -sf "$(pwd)/nvim" "$HOME/.config/nvim"
