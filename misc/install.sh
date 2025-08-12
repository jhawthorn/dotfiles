cd "$( dirname "$0" )"
ln -sf "$(pwd)/.agignore" "$HOME/.agignore"
ln -sf "$(pwd)/.wezterm.lua" "$HOME/.wezterm.lua"
ln -sf "$(pwd)/.inputrc" "$HOME/.inputrc"
ln -sf "$(pwd)/.ghostty" "$HOME/.config/ghostty/config"
ln -sf "$(pwd)/bashrc" "$HOME/.bashrc"
ln -sf "$(pwd)/npmrc" "$HOME/.npmrc"

mkdir -p "$HOME/.config/gdb"
ln -sf "$(pwd)/gdbearlyinit" "$HOME/.config/gdb/gdbearlyinit"

