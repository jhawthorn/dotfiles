#!/bin/zsh

mkdir -p "$HOME/bin"
cd `dirname "$0"`

files=(
autodisplay.rb
bgvim
chrome
dmenu_mpd
dmenu_run
dmenu_surfraw
dmenu_tv
dunst
git-recent
inspect
install_ruby
rline
roll
rtorrent
starcraft
statusbar
urlview
update_dotfiles
watchmsg
weechat
)

for name in $files; do
	ln -sf "$(pwd)/$name" "$HOME/bin/$name"
done
