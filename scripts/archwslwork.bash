#!/usr/bin/env bash

set -o errexit -o nounset

# Enable multilib
(cat /etc/pacman.conf | grep -q '^\[multilib\]') || sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

# Install required pkgs
sudo pacman -Sy --noconfirm --needed archlinux-keyring && sudo pacman -Su --noconfirm --needed
sudo pacman -S --noconfirm --needed git base-devel

# Update the system
sudo pacman -Syyuu --noconfirm --needed

# Install yay
if ! command -v yay &> /dev/null; then
  git clone https://aur.archlinux.org/yay.git
  cd yay && makepkg -si --noconfirm
  cd .. && rm -rf yay
fi

packages=(
  "ffmpeg htop wget git git-lfs openssh imagemagick curl usbutils udisks2 udiskie zip unzip unrar p7zip man-db man-pages texinfo networkmanager libappindicator-gtk3 aardvark-dns apparmor cifs-utils fuse-overlayfs strace gst-plugin-pipewire gst-plugins-good" # Base
  "zsh bat exa dust procs tmux fd fzf fselect-bin ripgrep neovim jq lsof urlview tldr" # terminal
  "podman podman-compose podman-docker podman-dnsname" # docker alternative
  "nodejs node-gyp npm yarn elixir go jdk11-openjdk jdk8-openjdk" # development
  "mariadb-clients memcached pgcli php redis ruby rust sqlite3 postgresql-libs" # development
  "helm python-pip python-numpy python-pandas python-pygments terraform terragrunt" # development
  "kubectl-bin kustomize openshift-client-bin skaffold-bin wrk" # development
  "mpv-mpris ncmpcpp mopidy mopidy-mpd yt-dlp" # media
)

# Install packages
yay -S --noconfirm --needed ${packages[@]}
