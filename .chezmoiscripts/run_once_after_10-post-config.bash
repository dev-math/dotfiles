#!/usr/bin/env bash

# Set default pywal color
wal -i ~/Pictures/wallpapers/dracula.png -e -s -t -q -n -o ~/.local/bin/afterwal

# Configure and enable cronjobs
crontab ~/.config/cronjobs
