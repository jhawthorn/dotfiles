cd "$( dirname "$0" )"

mkdir -p "$HOME/.config/aerospace"

ln -sfn "$(pwd)/aerospace.toml" "$HOME/.config/aerospace/aerospace.toml"
