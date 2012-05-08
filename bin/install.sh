cd "$( dirname "$0" )"
for name in autodisplay.rb  chrome  dunst  inspect  install.sh  mplayer  mplayer-youtube  rline  roll  starcraft  statusbar  urlview  watchmsg  weechat; do
	ln -sf "$(pwd)/$name" "$HOME/bin/$name"
done
