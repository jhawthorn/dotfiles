cd "$( dirname "$0" )"

mkdir -p "$HOME/.vim"
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/share/nvim/site"

rm -Rf "$HOME/.vim/bundle"
rm -Rf "$HOME/.vim/pack"
rm -Rf "$HOME/.config/nvim"
rm -Rf "$HOME/.local/share/nvim/site/pack"

ln -sfn "$(pwd)/.vimrc" "$HOME/.vimrc"
ln -sfn "$(pwd)/pack" "$HOME/.vim/pack"
ln -sfn "$(pwd)/nvim" "$HOME/.config/nvim"
ln -sfn "$(pwd)/nvim_pack" "$HOME/.local/share/nvim/site/pack"
