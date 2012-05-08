cd "$( dirname "$0" )"
mkdir -p "$HOME/.xmonad"
ln -sf "$(pwd)/xmonad.hs" "$HOME/.xmonad/xmonad.hs"
ln -nsf "$(pwd)/dzen" "$HOME/.dzen"
