cd "$( dirname "$0" )"

mkdir -p "$HOME/.config/awesome/themes"

ln -sf "$(pwd)/rc.lua" "$HOME/.config/awesome/rc.lua"
ln -sf "$(pwd)/hawth" "$HOME/.config/awesome/themes/hawth"

