#!/usr/bin/env bash
set -e

BACKUP_FOLDER="/home/$(whoami)/BACKUP-$(date +%Y.%m.%d-%H.%M.%S)"
backup_dirs=(
  "/home/$(whoami)/.config/i3"
  "/home/$(whoami)/.config/polybar"
  "/home/$(whoami)/.config/dunst"
  "/home/$(whoami)/.config/kitty"
  "/home/$(whoami)/.config/picom.conf"
  "/home/$(whoami)/.config/gtk-3.0"
  "/home/$(whoami)/.config/zathura"
  "/home/$(whoami)/.gtkrc-2.0"
  "/home/$(whoami)/.p10k.zsh"
  "/home/$(whoami)/.zshrc"
  "/home/$(whoami)/.xinitrc"
  "/home/$(whoami)/.xprofile"
)

function system_update() {
  msg "Updating some things..."
  sudo pacman -Syyuu --noconfirm --needed
}

function check_system_deps() {
  msg "Checking some things..."
  sudo pacman -S --noconfirm --needed base-devel flatpak
  sudo pacman -Sy --noconfirm --needed archlinux-keyring && sudo pacman -Syu --noconfirm --needed # TODO: check if this is correct

  if ! command -v git &>/dev/null; then
    msg "It seems that you don't have git installed. Would you like to install?"
    read -p "[y]es or [n]o (default: no) : " -r answer
    if [[ "$answer" != "${answer#[Yy]}" ]]; then
      sudo pacman -S --needed --noconfirm git
    else
      print_missing_dep_msg "git"
      exit 1
    fi
  fi

  if ! command -v yay &> /dev/null
  then
    msg "It seems that you don't have yay installed. Would you like to install?"
    read -p "[y]es or [n]o (default: no) : " -r answer
    if [[ "$answer" != "${answer#[Yy]}" ]]; then
      install_yay
    else
      print_missing_dep_msg "yay"
      exit 1
    fi
  fi
}

function install_yay() {
  git clone https://aur.archlinux.org/yay.git
  (cd yay && makepkg -si && rm -Rf $(pwd))
}

function install_fonts() {
  sudo pacman -S --needed --noconfirm noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra fontconfig
  mkdir -p ~/.local/share/fonts
  cp -r $DOTFILES_DIR/misc/fonts/* ~/.local/share/fonts/
  fc-cache
}

function install_video() {
  # TODO: install auto
  # sudo pacman -S --needed --noconfirm xf86-video-intel
  # sudo pacman -S --needed --noconfirm xf86-video-amdgpu
  # sudo pacman -S --needed --noconfirm nvidia nvidia-settings nvidia-utils
}


function install_base() {
  msg "Installing archieve and compress packages"
  yay -S --noconfirm --needed xclip udisks2 udiskie zip unzip unrar 7-zip lzop cpio ntfs-3g dosfstools exfat-utils f2fs-tools fuse fuse-exfat mtpfs sshfs gvfs man-db man-pages texinfo networkmanager maim xorg-server xorg-xinit archlinux-keyring

  msg "i3-gaps environment..." #TODO add msg title here
  yay -S --noconfirm --needed i3-gaps i3lock-color-git feh polybar picom rofi playerctl python-pywal flameshot \
    # obs-studio gucharmap xournalpp \ # Optional
    # xfce4-notifyd \
    dunst \
    kitty zsh bat exa neofetch \ # terminal config
    yarn rust \ # Lunarvim dependencies
    brave-bin discord qbittorrent torbrowser-launcher \ # Internet apps
    # chromium google-chrome firefox telegram-desktop qutebrowser \ # Internet apps optional
    thunar tunar-archive-plugin thunar-media-tags-plugin \ # Thunar file explorer
    ranger \ # Terminal file explorer
    eog \ # Image viewer
    qalculate-gtk \ # Calculator
    zathura zathura-djvu zathura-pdf-mupdf zathura-ps zathura-cb \ # PDF viewer #TODO
    kdeconnect \
    papirus-icon-theme-git \ # Icon theme
    alsa-utils alsa-plugins pulseaudio pulseaudio-alsa pavucontrol vlc # Audio apps

  msg "Installing Lunar Vim"
  [ -e ~/.local/bin/lvim ] && bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) #TODO chech if this is correct

  msg "Installing kotatogram"
  flatpak install flathub io.github.kotatogram

  msg "Installing Obsidian" #TODO check this name
  flatpak install flathub md.obsidian.Obsidian
}

function backup_old_config() {
  for dir in "${backup_dirs[@]}"; do
    if [ ! -e "$dir" ]; then
      continue
    fi
    mkdir -p "$BACKUP_FOLDER"
    current_dir_bak="$BACKUP_FOLDER/$(basename "$dir")-backup"
    msg "Backing up old $dir to $current_dir_bak"
    mv "$dir" "$current_dir_bak"
  done
}

function config_base() {
  if [[ $BACKUP = "no"]]; then
    msg "Backup deleted"
    rm -Rf $BACKUP_FOLDER
  else
    msg "Backup operation complete"
  fi

}

system_update
check_system_deps
install_fonts
install_video
install_base
backup_old_config
config_base
install_whitesur
