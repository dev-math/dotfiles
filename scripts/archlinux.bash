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
  # utils
  "accountsservice ffmpegthumbnailer gst-libav gst-plugin-pipewire gst-plugins-bad"
  "gst-plugins-ugly libdvdcss libgsf libopenraw mlocate poppler-glib xdg-user-dirs"
  "xdg-utils imagemagick usbutils udisks2 udiskie"
  "man-db man-pages texinfo cronie apparmor cifs-utils fuse-overlayfs strace"
  "electron electron29-bin hwinfo"
  # filesystem
  "efitools haveged nfs-utils nilfs-utils ntp smartmontools unrar unzip xz"
  # hardware libs
  "dmidecode dmraid hdparm hwdetect lsscsi mtools sg3_utils sof-firmware"
  # power
  "upower cpupower"
  "tlp"
  # "power-profiles-daemon"
  # audio
  "alsa-firmware alsa-utils alsa-plugins pavucontrol pipewire wireplumber"
  "pipewire-alsa pipewire-pulse pipewire-jack rtkit"
  # networks
  "networkmanager aardvark-dns"
  # bluetooth
  "bluez bluez-cups bluez-utils"
  # drivers
  # "mesa mesa-utils mesa-libgl lib32-mesa libvdpau-va-gl libva-mesa-driver"
  # "vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader"
  # "intel-media-driver intel-ucode"
  "thermald"
  # fonts
  "noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra fontconfig"
  # Printer
  "cups cups-filters cups-pdf foomatic-db foomatic-db-engine foomatic-db-gutenprint-ppds"
  "foomatic-db-nonfree foomatic-db-nonfree-ppds foomatic-db-ppds ghostscript gsfonts"
  "gutenprint splix system-config-printer"
  "hplip python-pyqt5 python-reportlab xsane"
  # rice 
  "hyprland-git waybar swaybg swaylock-effects-git light wlsunset kanshi nwg-displays"
  "xdg-desktop-portal-hyprland xdg-desktop-portal-termfilechooser-git"
  "wshowkeys-git python-pywal dunst swaync-git wlr-randr-git rofi-lbonn-wayland-git"
  "qt5-wayland qt6-wayland hyprpicker-git grimblast-git"
  "wl-clipboard wl-clip-persist-git"
  # development
  "podman podman-compose podman-docker"
  "nodejs node-gyp npm yarn elixir go jdk11-openjdk jdk8-openjdk pgcli php ruby"
  "mariadb-clients memcached redis r rust sqlite lib32-sqlite postgresql-libs"
  "python-pip python-numpy python-pandas python-pygments wrk"
  # terminal
  "wget ripgrep git git-lfs openssh curl htop zsh exa bat dust procs tmux fd fzf"
  "foot fselect-bin ripgrep neovim jq lsof urlview tealdeer nnn-nerd"
  # internet
  "librewolf-bin torbrowser-launcher telegram-desktop rclone syncthing kdeconnect"
  "zerotier-one discord webcord-git"
  # media
  "zathura zathura-djvu zathura-pdf-mupdf zathura-ps zathura-cb"
  "gimp inkscape krita xournalpp"
  "imv playerctl mpv mpv-mpris ncmpcpp yt-dlp obs-studio"
  # games
  "lib32-gamemode gamemode steam lutris"
  # misc
  "qalculate-gtk"
  # Wine dependencies
  "wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error lib32-alsa-plugins libjpeg-turbo lib32-libjpeg-turbo libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses ocl-icd lib32-ocl-icd libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vkd3d lib32-vkd3d"
)

# Install packages
yay -S --noconfirm --needed --ask 4 ${packages[@]}

# add user to groups
sudo usermod -a -G video,audio,gamemode $(whoami)
