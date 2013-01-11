#!/bin/zsh

systemd --user &

export _JAVA_AWT_WM_NONREPARENTING=1

xsetroot -cursor_name watch

xrdb -merge ~/.Xresources
xset +fp /usr/share/fonts/local
xset fp rehash
xset -b

urxvtd -q -o -f

xsetroot -solid black
xsetroot -cursor_name left_ptr

xbindkeys &

exec awesome

