cd "$( dirname "$0" )"

mkdir -p "$HOME/.config/awesome"

ln -sf "$(pwd)/rc.lua" "$HOME/.config/awesome/rc.lua"

