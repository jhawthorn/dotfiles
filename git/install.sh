cd "$( dirname "$0" )"
ln -sf "$(pwd)/.gitconfig" "$HOME/.gitconfig"
ln -sf "$(pwd)/.gitignore" "$HOME/.gitignore"

mkdir -p "$HOME/.config/gh"
ln -sf "$(pwd)/gh_config.yml" "$HOME/.config/gh/config.yml"

