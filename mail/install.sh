cd "$( dirname "$0" )"
ln -sf "$(pwd)/.msmtprc"       "$HOME/.msmtprc"
ln -sf "$(pwd)/.muttrc"        "$HOME/.muttrc"
ln -sf "$(pwd)/.offlineimaprc" "$HOME/.offlineimaprc"

mkdir -p "$HOME/.mutt"
ln -sf "$(pwd)/mutt/colors.linux" "$HOME/.mutt/colors.linux"
ln -sf "$(pwd)/mutt/mailcap"      "$HOME/.mutt/mailcap"
