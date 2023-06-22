#!/bin/env bash

SND_STATUS=$(playerctl --player=playerctld status 2>/dev/null)

PREVIOUS="玲"
TEXT=$(playerctl --player=playerctld metadata --format "{{ title }} - {{ artist }}" 2>/dev/null)
NEXT="怜"

if ([ "$SND_STATUS" = "Playing" ] || [ "$SND_STATUS" = "Paused" ]) && [ "$TEXT" != "" ]
then
  if [[ $1 = "metadata" ]]; then
    echo "{\"text\":\""$TEXT"\"}"
  elif [[ $1 = "previous" ]]; then
    echo "{\"text\":\""$PREVIOUS"\",\"class\":\"previous\"}"
  elif [[ $1 = "next" ]]; then
    echo "{\"text\":\""$NEXT"\",\"class\":\"next\"}"
  fi
else
	echo ""
fi
