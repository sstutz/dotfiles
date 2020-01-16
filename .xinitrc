#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi


if [ -f "$HOME/.Xresources" ]; then
    xrdb -merge "$HOME/.Xresources"
fi


if [ -f "$HOME/.Xmodmap" ]; then
    xmodmap "$HOME/.Xmodmap"
fi

if [ -f "$HOME/.config/compton.conf" ]; then
    if command -v compton >/dev/null 2>&1; then
        compton -b --config $HOME/.config/compton.conf \
            --opacity-rule '100:window_type = "dock" && class_g = "i3blocks"'
    else
        echo >&2 "compton configuration exists but is not installed.";
    fi
fi

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

setxkbmap -layout gb


exec /usr/bin/i3 -V >/tmp/i3-$(date +'%F-%k-%M-%S').log 2>&1
