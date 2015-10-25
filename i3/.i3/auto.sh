#!/usr/bin/bash

# startup dropbox
if [[ ! $(pgrep dropbox) ]]; then
    dropboxd &
else
    echo "dropbox is running already"
fi

# restore wallpaper
if [[ -f ~/.fehbg ]]; then
    sh ~/.fehbg &
fi

# start screencloud
if [[ -x /usr/bin/screencloud ]]; then
    screencloud &
fi


# start google music client
if [[ -x /usr/bin/google-musicmanager ]]; then
    google-musicmanager &
fi


# start the network manager
if [[ -x /usr/bin/nm-applet ]]; then
    nm-applet &
fi

# start xautolock
xautolock -time 15 -locker "$HOME/.i3/screenlock.sh" -corners 0-00 &
