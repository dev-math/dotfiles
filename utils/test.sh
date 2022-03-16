#!/usr/bin/env bash
set -e

DOTFILES_DIR=/home/$(whoami)/.dotfiles
BACKUP=false
BACKUP_FOLDER="/home/$(whoami)/BACKUP-$(date +%Y.%m.%d-%H.%M.%S)"
backup_dirs=(
  "/home/$(whoami)/.config/i3 $DOTFILES_DIR/config/i3 $DOTFILES_DIR/"
  "/home/$(whoami)/.config/polybar $DOTFILES_DIR/config/polybar"
  "/home/$(whoami)/.config/dunst $DOTFILES_DIR/config/dunst"
  # "/home/$(whoami)/.config/kitty $DOTFILES_DIR/config/kitty"
  "/home/$(whoami)/.config/lvim/config.lua $DOTFILES_DIR/config/lunarvim.lua"
  "/home/$(whoami)/.config/picom.conf $DOTFILES_DIR/config/picom.conf"
  "/home/$(whoami)/.config/gtk-3.0 $DOTFILES_DIR/config/gtk-3.0"
  "/home/$(whoami)/.gtkrc-2.0 $DOTFILES_DIR/gtkrc-2.0"
  "/home/$(whoami)/.zsh $DOTFILES_DIR/zsh"
  "/home/$(whoami)/.zshrc $DOTFILES_DIR/zshrc"
  "/home/$(whoami)/.xinitrc $DOTFILES_DIR/xinitrc"
  "/home/$(whoami)/.xprofile $DOTFILES_DIR/xprofile"
)

source $DOTFILES_DIR/utils/sharedfuncs.sh

function backup() {
  if [[ $BACKUP = false ]]; then
    rm -Rf $source
  else
    if [[ -e "$1" ]]; then
      mkdir -p "$BACKUP_FOLDER"
      current_dir_bak="$BACKUP_FOLDER/$(basename "$1")-backup"
      msg "Backing up old $1 to $current_dir_bak"
      mv "$1" "$current_dir_bak"
    fi
  fi
}

function system_update() {
  msg "Updating some things..."
  sudo pacman -Syyuu --noconfirm --needed
}

function check_system_deps() {
  msg "Checking some things..."
  sudo pacman -S --noconfirm --needed base-devel flatpak
  sudo pacman -Sy --noconfirm --needed archlinux-keyring && sudo pacman -Su --noconfirm --needed

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
  msg "Installing base packages"
  yay -S --noconfirm --needed xclip udisks2 udiskie zip unzip unrar 7-zip lzop cpio ntfs-3g dosfstools exfat-utils f2fs-tools fuse fuse-exfat mtpfs sshfs gvfs man-db man-pages texinfo networkmanager maim xorg-server xorg-xinit

  msg "Installing apps that I use..."
  yay -S --noconfirm --needed i3-gaps i3lock-color-git feh polybar picom rofi playerctl python-pywal flameshot \
    dunst \ # notifications | optional: xfce4-notifyd
    rxvt-unicode zsh bat exa neofetch \ # terminal config | optional: kitty
    brave-bin discord qbittorrent torbrowser-launcher \ # Internet apps
    # thunar thunar-archive-plugin thunar-media-tags-plugin \ # Thunar file explorer
    ranger \ # Terminal file explorer
    eog \ # Image viewer
    mpv mpv-mpris \ # Video Player | optional: vlc
    alsa-utils alsa-plugins pulseaudio pulseaudio-alsa pavucontrol \ # Audio apps
    qalculate-gtk \ # Calculator
    zathura zathura-djvu zathura-pdf-mupdf zathura-ps zathura-cb \ # PDF viewer
    papirus-icon-theme-git \ # Icon theme
    # 0ad wesnoth \ # Games
    # obs-studio gucharmap xournalpp chromium google-chrome firefox telegram-desktop qutebrowser \ # Optional
    kdeconnect

  if [ ! -e ~/.local/bin/lvim ]; then
    msg "Installing Lunar Vim"
    yay -S --needed --noconfirm yarn rust
    bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
  fi

  msg "Installing kotatogram"
  flatpak install flathub io.github.kotatogram

  msg "Installing Obsidian"
  flatpak install flathub md.obsidian.Obsidian
}

function config_base() {
  for dir in "${backup_dirs[@]}"; do
    IFS=" "
    read -a strarr <<< "$dir"
    source=${strarr[0]}
    dest=${strarr[1]}

    backup "$source"
    ln -sf $dest $source
  done

  mkdir -p ~/.urxvt/ext && cp -r $DOTFILES_DIR/urxvt/* ~/.urxvt/ext/ # Install URxvt perl extensions
  # config_xfce4notifyd

  # Blacklist PC speaker module
  echo "blacklist pcspkr" > nobeep.conf
  sudo mv nobeep.conf /etc/modprobe.d/nobeep.conf
}

function config_pywal() {
  mkdir -p ~/.config/wal/templates/ && cp -r $DOTFILES_DIR/config/wal/templates/* ~/.config/wal/templates/
  wal -i ~/Pictures/wallpapers/sereneforest.jpg -e -s -t -q -n
  # Symlink pywal files
  sed -i "s/math/$(whoami)/g" ~/.config/wal/templates/flameshot.ini
  backup "~/.config/flameshot" && mkdir -p ~/.config/flameshot && ln -sf ~/.cache/wal/flameshot ~/.config/flameshot/flameshot.ini
  backup "~/.config/zathura" && mkdir -p ~/.config/zathura && ln -sf ~/.cache/wal/zathurarc ~/.config/zathura/zathurarc
  backup "~/.config/dunst" && mkdir -p ~/.config/dunst && ln -sf ~/.cache/wal/dunstrc ~/.config/dunst/dunstrc
  backup "~/.Xresources" && ln -sf ~/.cache/wal/Xresources ~/.Xresources
}

function install_whitesur() {
  git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
  (cd WhiteSur-icon-theme && ./install.sh && rm -Rf $(pwd))
  git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
  (cd WhiteSur-gtk-theme && ./install.sh && rm -Rf $(pwd))
  echo 'gtk-theme-name="WhiteSur-dark"' >> ~/.gtkrc-2.0
  echo 'gtk-icon-theme-name="WhiteSur-dark"' >> ~/.gtkrc-2.0
  echo 'gtk-theme-name=WhiteSur-dark' >> ~/.config/gtk-3.0/settings.ini
  echo 'gtk-icon-theme-name=WhiteSur-dark' >> ~/.config/gtk-3.0/settings.ini
}

function config_xfce4notifyd() {
  echo "" >> ~/.xprofile
  echo "# Start notifications" >> ~/.xprofile
  echo "/usr/lib/xfce4/notifyd/xfce4-notifyd &" >> ~/.xprofile
  sed -i "s/refreshDunst/refreshXfceNotify/g" ~/.config/polybar/modules.ini
  sed -i "s/toggleDunst/toggleXfceNotify/g" ~/.config/polybar/modules.ini
}

msg "Would you like to install the required fonts?"
read -p "[y]es or [n]o (default: no) : " -r answer
[ "$answer" != "${answer#[Yy]}" ] && BACKUP=true

system_update
check_system_deps
install_fonts
install_video
install_base
config_base
config_pywal
install_whitesur
