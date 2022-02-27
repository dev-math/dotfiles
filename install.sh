#!/usr/bin/env bash
set -e

echo "Checking some things, updating others..."
sudo pacman -Syu --noconfirm --needed base-devel git fontconfig

# install AUR helper (yay)
if ! command -v yay &> /dev/null
then
    echo "It seems that you don't have yay installed, I'll install that for you before continuing."
    git clone https://aur.archlinux.org/yay.git
    (cd $HELPER && makepkg -si && rm -Rf $(pwd))
fi

# install fonts

mkdir -p ~/Projects ~/Downloads ~/Documents ~/Desktop
mkdir -p ~/Pictures/wallpapers ~/Pictures/screenshots
