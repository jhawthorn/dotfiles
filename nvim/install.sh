cd "$( dirname "$0" )"

mkdir -p "$HOME/.config"

rm -Rf "$HOME/.config/nvim"
rm -Rf "$HOME/.local/share/nvim/site/pack"

ln -sfn "$(pwd)/nvim" "$HOME/.config/nvim"
