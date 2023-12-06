#!/usr/bin/env bash

set -o errexit -o nounset

# Enable multilib
(cat /etc/pacman.conf | grep -q '^\[multilib\]') || sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

# Install required pkgs
sudo pacman -Sy --noconfirm --needed archlinux-keyring && sudo pacman -Su --noconfirm --needed
sudo pacman -S --noconfirm --needed flatpak git base-devel

# Update the system
sudo pacman -Syyuu --noconfirm --needed

# Install yay
if ! command -v yay &> /dev/null; then
  git clone https://aur.archlinux.org/yay.git
  cd yay && makepkg -si --noconfirm
  cd .. && rm -rf yay
fi

packages=(
  "ffmpeg htop wget git git-lfs openssh imagemagick curl usbutils udisks2 udiskie zip unzip unrar p7zip man-db man-pages texinfo networkmanager cronie libappindicator-gtk3 aardvark-dns apparmor cifs-utils fuse-overlayfs strace gst-plugin-pipewire gst-plugins-good mlocate" # Base
  "cups system-config-printer" # Printer
  "sway swaylock-effects-git swaybg i3status-rust xorg-xwayland wl-clipboard wf-recorder clipmon-git rofi-lbonn-wayland-git xdg-desktop-portal xdg-desktop-portal-wlr grim slurp playerctl dunst python-pywal" # sway setup
  "alacritty zsh bat exa dust procs tmux fd fzf fselect-bin ripgrep neovim jq lsof urlview tldr" # terminal
  "podman podman-compose podman-docker podman-dnsname" # docker alternative
  "rclone" # google drive mount and backup
  "nodejs node-gyp npm yarn elixir go jdk11-openjdk jdk8-openjdk" # development
  "mariadb-clients memcached pgcli php redis r ruby rust sqlite3 postgresql-libs" # development
  "helm python-pip python-numpy python-pandas python-pygments terraform terragrunt" # development
  "kubectl-bin kustomize openshift-client-bin skaffold-bin wrk" # development
  "feh mpv-mpris ncmpcpp mopidy mopidy-mpd yt-dlp" # media
  "alsa-utils alsa-plugins pavucontrol pipewire wireplumber pipewire-alsa pipewire-pulse pipewire-jack"
  "bluez bluez-utils" # bluetooth
  "zathura zathura-djvu zathura-pdf-mupdf zathura-ps zathura-cb" # PDF viewer
  "papirus-icon-theme-git" # Icon theme
  "light gammastep kanshi wdisplays-git wshowkeys-git" # screen
  "kdeconnect"
  "noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra fontconfig" # fonts
  "thunar thunar-archive-plugin thunar-media-tags-plugin" # Thunar file explorer
  "mesa mesa-utils mesa-libgl libvdpau-va-gl libva-mesa-driver vkd3d lib32-vkd3d"
  "xf86-video-intel libva-intel-driver"
  "lib32-gamemode gamemode"
  "tlp" # battery
  "thermald intel-ucode" # Intel CPU
)

# Install packages
yay -S --noconfirm --needed ${packages[@]}

# add user to groups
sudo usermod -a -G wheel,video $(whoami)

# enable pipewire
systemctl --user enable pipewire.service pipewire.socket pipewire-pulse.service wireplumber.service

# enable tlp for battery power saving
systemctl enable --now tlp.service
systemctl mask systemd-rfkill.service
systemctl mask systemd-rfkill.socket

systemctl enable --now cronie
