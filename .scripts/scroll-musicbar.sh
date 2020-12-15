#!/bin/bash
zscroll -l 25 \
        --delay 0.1 \
        --update-check true '/home/math/.dotfiles/.scripts/musicbar.sh' &
wait
