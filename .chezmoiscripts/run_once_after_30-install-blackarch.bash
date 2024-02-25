#!/usr/bin/env bash
exit 0 # in test
set -o errexit -o nounset

curl -O https://blackarch.org/strap.sh
sudo chmod +x strap.sh
sudo ./strap.sh

sudo pacman -Syyu

sudo pacman -S --needed --noconfirm blackarch
