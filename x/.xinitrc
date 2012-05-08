#!/bin/zsh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

export _JAVA_AWT_WM_NONREPARENTING=1

xsetroot -cursor_name watch

xrdb -merge ~/.Xresources

/home/jhawthorn/bin/autodisplay.rb

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xset -b

urxvtd -q -o -f
/home/jhawthorn/bin/dunst &

xsetroot -solid black
xsetroot -cursor_name left_ptr

/home/jhawthorn/bin/statusbar &

# exec gnome-session
# exec startkde
# exec startxfce4

offlineimap -u silent &

exec ck-launch-session xmonad
#exec ck-launch-session openbox

