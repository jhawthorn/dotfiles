cd "$( dirname "$0" )"

mkdir -p "$HOME/.vim"
mkdir -p "$HOME/.config"

rm -Rf "$HOME/.vim/bundle"
rm -Rf "$HOME/.vim/pack"

ln -sfn "$(pwd)/.vimrc" "$HOME/.vimrc"
ln -sfn "$(pwd)/pack" "$HOME/.vim/pack"
