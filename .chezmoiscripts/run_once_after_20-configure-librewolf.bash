#!/usr/bin/env bash

set -o errexit -o nounset
# Start librewolf in headless mode in order to create config directory for it.
mkdir -p $HOME/.librewolf
librewolf --headless >/dev/null 2>&1 &
sleep 3
killall librewolf

# Find the profile folder.
LIBREW_CONFIG_DIR="$HOME/.librewolf"
LIBREW_PROF_NAME="$(sed -n "/Default=.*.default-release/ s/.*=//p" "$LIBREW_CONFIG_DIR/profiles.ini")"
LIBREW_CHROME_DIR="$LIBREW_CONFIG_DIR/$LIBREW_PROF_NAME/chrome"

mkdir -p "$LIBREW_CHROME_DIR"
cp "$CHEZMOI_SOURCE_DIR/dot_config/userChrome.css" "$LIBREW_CHROME_DIR"

# Configure mpv firefox add-on
xdg-mime default mpv-scheme-handler.desktop x-scheme-handler/mpv
