curl -sSL -o /Applications/WezTerm.app/Contents/Resources/terminal.icns https://raw.githubusercontent.com/mikker/wezterm-icon/main/wezterm.icns
rm /var/folders/*/*/*/com.apple.dock.iconcache
rm -r /var/folders/*/*/*/com.apple.iconservices*
killall Dock
