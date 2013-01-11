cd "$( dirname "$0" )"

mkdir -p "$HOME/.ncmpcpp"
mkdir -p "$HOME/.config/beets"

ln -sf "$(pwd)/ncmpcpp_config" "$HOME/.ncmpcpp/config"
ln -sf "$(pwd)/beetsconfig.yaml" "$HOME/.config/beets/config.yaml"
ln -sf "$(pwd)/mpdconf" "$HOME/.mpdconf"

