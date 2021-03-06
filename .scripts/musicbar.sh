#!/bin/bash

SND_STATUS=$(playerctl --player=playerctld status 2>/dev/null)

get_text()
{
    if [ "$(playerctl -l | grep 'spotify')" = "spotify" ]; then
        echo $(playerctl --player=spotify metadata --format "{{ title }} - {{ artist }}")
    else
        echo $(playerctl --player=playerctld metadata --format "{{ title }}")
    fi
}

if [ "$SND_STATUS" = "Playing" ]; then
    get_text
elif [ "$SND_STATUS" = "Paused" ]; then
    get_text
else
    echo ""
fi
