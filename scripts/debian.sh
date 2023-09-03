#!/usr/bin/env sh
  
set -o errexit -o nounset

sudo dpkg --add-architecture i386

# Enabling contrib and non-free repositories
sudo sed -i -e 's/main$/main contrib non-free/g' /etc/apt/sources.list

# lutris
echo "deb [signed-by=/etc/apt/keyrings/lutris.gpg] https://download.opensuse.org/repositories/home:/strycore/Debian_12/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list > /dev/null
wget -q -O- https://download.opensuse.org/repositories/home:/strycore/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/keyrings/lutris.gpg > /dev/null

# Brave
sudo apt install curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update -y && sudo apt upgrade -y

packages=(
  "meson libsystemdfdev pkg-config ninja-build git libdbus-1-dev libinih-dev build-essential ffmpeg htop wget openssh-server usbutils udisks2 udiskie zip unzip unrar p7zip network-manager libappindicator3-1 flatpak" # Base
  "cups system-config-printer" # Printer
  "sway swaylock swaybg swayidle i3status-rust xwayland wl-clipboard wf-recorder clipmon-git rofi-lbonn-wayland-git xdg-desktop-portal xdg-desktop-portal-wlr grim flameshot playerctl dunst python-pywal" # sway setup
  "alacritty zsh bat exa neofetch tmux rust-fd-find fzf ripgrep neovim" # terminal
  "podman" # docker alternative
  "firefox-esr brave-browser rclone qbittorrent torbrowser-launcher obs-studio" # Internet apps
  "telegram-desktop"
  "feh mpv mpv-mpris" # media
  "alsa-utils pavucontrol pipewire-audio pipewire-jack"
  "bluetooth bluez bluez-tools" # bluetooth
  "qalculate-gtk" 
  "zathura zathura-djvu zathura-pdf-mupdf zathura-ps zathura-cb" # PDF viewer
  "papirus-icon-theme" # Icon theme
  "light gammastep kanshi wdisplays" # screen
  "kdeconnect"
  "fonts-noto fonts-noto-cjk fonts-noto-color-emoji fontconfig" # fonts
  "thunar thunar-archive-plugin thunar-media-tags-plugin" # Thunar file explorer
  "mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386 xserver-xorg-core"
  "lutris wine wine32 libwine libwine:i386 fonts-wine gamemode steam"
  "tlp" # battery
  "thermald intel-microcode" # Intel CPU
)

sudo apt install -y ${packages[@]}

systemctl --user --now enable wireplumber.service

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.discordapp.Discord

flatpak install flathub md.obsidian.Obsidian
