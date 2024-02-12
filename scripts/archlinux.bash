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
  "ffmpeg htop wget git git-lfs openssh imagemagick curl usbutils udisks2 udiskie zip unzip unrar p7zip man-db man-pages texinfo networkmanager cronie libappindicator-gtk3 aardvark-dns apparmor cifs-utils fuse-overlayfs strace gst-plugin-pipewire gst-plugins-good mlocate xdg-desktop-portal xdg-desktop-portal-wlr-git dunst playerctl python-pywal" # Base
  "librewolf-bin torbrowser-launcher telegram-desktop rclone syncthing zerotier-one discord qbittorrent" # Internet apps
  "cups system-config-printer" # Printer
  "xorg-xrandr xorg-server xorg-xgamma xorg-xinit xclip i3-wm i3lock-color-git i3status-rust picom rofi parcellite" # i3 setup
  "alacritty zsh bat exa dust procs tmux fd fzf fselect-bin ripgrep neovim jq lsof urlview tldr" # terminal
  "podman podman-compose podman-docker podman-dnsname" # docker alternative
  "nodejs node-gyp npm yarn elixir go jdk11-openjdk jdk8-openjdk" # development
  "mariadb-clients memcached pgcli php redis r ruby rust sqlite lib32-sqlite postgresql-libs" # development
  "helm python-pip python-numpy python-pandas python-pygments terraform terragrunt" # development
  "kubectl-bin kustomize openshift-client-bin skaffold-bin wrk" # development
  "imv mpv mpv-mpris ncmpcpp yt-dlp obs-studio flameshot-git" # media
  "alsa-utils alsa-plugins pavucontrol pipewire wireplumber pipewire-alsa pipewire-pulse pipewire-jack" # audio
  "bluez bluez-utils" # bluetooth
  "zathura zathura-djvu zathura-pdf-mupdf zathura-ps zathura-cb" # PDF viewer
  "papirus-icon-theme-git" # Icon theme
  "light redshift autorandr arandr" # screen
  "kdeconnect"
  "noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra fontconfig" # fonts
  "thunar thunar-archive-plugin thunar-media-tags-plugin" # Thunar file explorer
  "mesa mesa-utils mesa-libgl lib32-mesa libvdpau-va-gl libva-mesa-driver vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader intel-media-driver intel-hybrid-codec-driver-git"
  # Wine dependencies
  "wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error lib32-alsa-plugins libjpeg-turbo lib32-libjpeg-turbo libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses ocl-icd lib32-ocl-icd libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vkd3d lib32-vkd3d"
  "lib32-gamemode gamemode steam lutris"
  "tlp" # battery
  "thermald intel-ucode" # Intel CPU
  "gimp qalculate-gtk"
)

# Install packages
yay -S --noconfirm --needed ${packages[@]}
# sudo python3 -m pip install Mopidy-YTMusic --break-system-packages

# add user to groups
sudo usermod -a -G wheel,video $(whoami)

# enable pipewire
systemctl --user enable pipewire.service pipewire.socket pipewire-pulse.service wireplumber.service

# enable tlp for battery power saving
systemctl enable --now tlp.service
systemctl mask systemd-rfkill.service
systemctl mask systemd-rfkill.socket

# thermald prevent overheating on intel CPUs
systemctl enable --now thermald

systemctl enable --now cronie

# disable systemd lid events
sed -e 's/#HandleLidSwitch=suspend/HandleLidSwitch=ignore/g' -e 's/#HandleLidSwitchExternalPower=suspend/HandleLidSwitchExternalPower=ignore/g' /etc/systemd/logind.conf > tmp_file && sudo mv tmp_file /etc/systemd/logind.conf
