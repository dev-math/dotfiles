#!/usr/bin/env sh

set -o errexit -o nounset

# Enable multilib
(cat /etc/pacman.conf | grep -q '^\[multilib\]') || sudo sed -i \"/\[multilib\]/,/Include/\"'s/^#//' /etc/pacman.conf

# Update the system
sudo pacman -Syyuu --noconfirm --needed

# Install yay
if ! command -v yay &> /dev/null; then
  git clone https://aur.archlinux.org/yay.git
  cd yay && makepkg -si --noconfirm
  cd .. && rm -rf yay
fi

packages=(
  "ffmpeg htop wget openssh curl usbutils udisks2 udiskie zip unzip unrar p7zip man-db man-pages texinfo networkmanager cronie libappindicator-gtk3" # Base
  "cups system-config-printer" # Printer
  "sway swaylock swaybg i3status-rust xorg-xwayland wl-clipboard wf-recorder clipmon-git rofi-lbonn-wayland-git xdg-desktop-portal xdg-desktop-portal-wlr grim flameshot-git playerctl dunst python-pywal" # sway setup
  "alacritty zsh bat exa neofetch tmux fd fzf ripgrep neovim" # terminal
  "podman" # docker alternative
  "firefox brave-bin rclone qbittorrent torbrowser-launcher obs-studio" # Internet apps
  "obsidian" # note taking
  "discord discord-screenaudio telegram-desktop"
  "nodejs npm"
  "feh mpv mpv-mpris" # media
  "alsa-utils alsa-plugins pavucontrol pipewire wireplumber pipewire-alsa pipewire-pulse pipewire-jack"
  "bluez bluez-utils" # bluetooth
  "qalculate-gtk" 
  "zathura zathura-djvu zathura-pdf-mupdf zathura-ps zathura-cb" # PDF viewer
  "papirus-icon-theme-git" # Icon theme
  "light gammastep kanshi wdisplays-git wshowkeys-git" # screen
  "kdeconnect"
  "noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra fontconfig" # fonts
  "thunar thunar-archive-plugin thunar-media-tags-plugin" # Thunar file explorer
  "mesa mesa-utils mesa-libgl libvdpau-va-gl libva-mesa-driver vkd3d lib32-vkd3d"
  "xf86-video-intel libva-intel-driver"
  "lutris wine lib32-gamemode gamemode steam"
  "tlp" # battery
  "thermald intel-ucode" # Intel CPU
  # "xf86-video-amdgpu" # AMD GPU
  # "nvidia nvidia-utils nvidia-settings" # Nvidia GPU
  # "gucharmap xournalpp chromium google-chrome qutebrowser" # Optional
  # "ranger" # Terminal file explorer
)

# Install packages
yay -S --noconfirm --needed ${packages[@]}

# enable pipewire
systemctl --user enable pipewire.service pipewire.socket pipewire-pulse.service wireplumber.service

# enable tlp for battery power saving
systemctl enable --now tlp.service
systemctl mask systemd-rfkill.service
systemctl mask systemd-rfkill.socket

systemctl enable --now cronie
