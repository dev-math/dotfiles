#!/usr/bin/env bash

setxkbmap br &

if (! pgrep nm-applet); then
    nm-applet &   
fi

if (! pgrep kdeconnect-indi); then
    kdeconnect-indicator &   
fi

if (! pgrep picom); then
    picom &
fi

if (! pgrep Discord); then
    discord &
fi
