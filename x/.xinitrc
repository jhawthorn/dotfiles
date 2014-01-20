#!/bin/zsh

export PATH="$HOME/bin:$PATH"

xset +fp /usr/share/fonts/local
xset fp rehash

export _JAVA_AWT_WM_NONREPARENTING=1

eval `gpg-agent -s --enable-ssh-support --daemon`

xsetroot -cursor_name watch

xrdb -merge ~/.Xresources
xset +fp /usr/share/fonts/local
xset fp rehash
xset -b

/usr/lib/systemd/systemd --user &

urxvtd -q -o -f

xsetroot -solid black
xsetroot -cursor_name left_ptr

exec awesome

