#!/usr/bin/env bash
  
set -o errexit -o nounset

# Enabling contrib and non-free repositories
sudo apt install ca-certificates curl gnupg software-properties-common
sudo apt-add-repository non-free -y
sudo apt-add-repository contrib -y

sudo dpkg --add-architecture i386

# nodejs
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

# lutris
echo "deb [signed-by=/etc/apt/keyrings/lutris.gpg] https://download.opensuse.org/repositories/home:/strycore/Debian_12/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list > /dev/null
wget -q -O- https://download.opensuse.org/repositories/home:/strycore/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/keyrings/lutris.gpg > /dev/null

# Brave
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update -y && sudo apt upgrade -y

packages=(
  "wayland-protocols libwayland-dev libinput-dev cmake check meson libsystemd-dev pkg-config ninja-build git libdbus-1-dev libinih-dev build-essential ffmpeg htop wget openssh-server usbutils udisks2 udiskie zip unzip unrar p7zip network-manager libappindicator3-1 flatpak" # Base
  "cups system-config-printer" # Printer
  "sway swaybg swayidle xwayland wl-clipboard wf-recorder xdg-desktop-portal xdg-desktop-portal-wlr grim flameshot playerctl dunst" # sway setup
  "alacritty zsh bat exa neofetch tmux fd-find fzf ripgrep neovim" # terminal
  "podman" # docker alternative
  "nodejs"
  "firefox-esr brave-browser rclone qbittorrent torbrowser-launcher obs-studio" # Internet apps
  "telegram-desktop"
  "feh mpv mpv-mpris" # media
  "libasound2 alsa-utils pavucontrol pipewire-audio pipewire-jack"
  "bluetooth bluez bluez-tools" # bluetooth
  "qalculate-gtk" 
  "zathura zathura-djvu zathura-pdf-poppler zathura-ps zathura-cb" # PDF viewer
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

# Install pywal
if ! command -v wal &> /dev/null; then
  sudo apt install -y pipx python3-pip
  pipx install pywal
fi

# Install Rofi
if ! command -v rofi &> /dev/null; then
  sudo apt install -y libxcb-icccm4-dev libgdk-pixbuf2.0-dev libpango1.0-dev libxcb-xkb-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-util-dev libstartup-notification0-dev flex bison libxkbcommon-x11-dev
  git clone https://github.com/lbonn/rofi.git
  cd rofi
  meson setup build
  ninja -C build
  sudo ninja -C build install
  cd .. && rm -Rf rofi
fi

# Swaylock
if ! command -v swaylock &> /dev/null; then
  sudo apt install -y libpam0g-dev
  git clone https://github.com/mortie/swaylock-effects.git
  cd swaylock-effects
  meson setup build
  ninja -C build
  sudo ninja -C buiid install
  cd .. && rm -Rf swaylock-effects
fi

# Install wshowkeys
if ! command -v wshowkeys &> /dev/null; then
  git clone https://github.com/ammgws/wshowkeys.git
  cd wshowkeys
  meson setup build
  ninja -C build
  sudo ninja -C build install
  sudo chmod a+s /usr/local/bin/wshowkeys
  cd .. && rm -Rf wshowkeys
fi

# Install i3status-rust
if ! command -v i3status-rs &> /dev/null; then
  if ! command -v rustc &> /dev/null; then
    curl https://sh.rustup.rs -sSf | sh -s -- --profile complete --no-modify-path
  fi
  sudo apt install -y cargo libssl-dev libsensors-dev libpulse-dev
  git clone https://github.com/greshake/i3status-rust
  cd i3status-rust
  cargo install --path . --locked
  ./install.sh || true
  cd .. && rm -Rf i3status-rust 
fi

# Install clipmon
if [[ ! -e /usr/lib/clipmon ]]; then
  git clone https://git.sr.ht/~whynothugo/clipmon
  cd clipmon
  make clipmon
  make install
  sudo cp clipmon.service /etc/systemd/system
  systemctl enable --now clipmon
  cd .. && rm -Rf clipmon
fi

systemctl --user --now enable wireplumber.service

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.discordapp.Discord

flatpak install flathub md.obsidian.Obsidian
