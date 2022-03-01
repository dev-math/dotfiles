#!/usr/bin/env bash
set -e

DOTFILES_DIR=/home/$(whoami)/.dotfiles

# backup: i3, polybar, dunst, kitty, lvim, picom, .p10k, zshrc, xprofile, xresources, xinitrc
backup_dirs=(
)
source $DOTFILES_DIR/utils/sharedfuncs.sh

function main() {
  msg "...Script can be cancelled at any time with CTRL+C"

  msg "Would you like to install the required fonts?"
  read -p "[y]es or [n]o (default: no) : " -r answer
  [ "$answer" != "${answer#[Yy]}" ] && install_fonts

  check_system_deps
  backup_old_config
}

#TODO: Add rsync option to backup if exist
# rsync --archive -hh --stats --partial --copy-links --cvs-exclude "$dir"/ "$current_dir_bak"
function backup_old_config() {
  BACKUP_FOLDER="/home/$(whoami)/BACKUP-$(date +%Y.%m.%d-%H.%M.%S)"
  for dir in "${backup_dirs[@]}"; do
    if [ ! -e "$dir" ]; then
      continue
    fi
    mkdir -p "$BACKUP_FOLDER"
    current_dir_bak="$BACKUP_FOLDER/$(basename "$dir")-backup"
    msg "Backing up old $dir to $current_dir_bak"
    mv "$dir" "$current_dir_bak"
  done
  msg "Backup operation complete"
}

function system_update() {
  msg "Checking some things, updating others..."
  sudo pacman -Syyuu --noconfirm 
}

function check_system_deps() {
  msg "Can I update your system and install some essential packages? 👉👈"
  read -p "[y]es or [n]o (default: no) : " -r answer
  [ "$answer" != "${answer#[Yy]}" ] && system_update && sudo pacman -S --noconfirm --needed base-devel fontconfig

  if ! command -v git &>/dev/null; then
    msg "It seems that you don't have git installed. Would you like to install?"
    read -p "[y]es or [n]o (default: no) : " -r answer
    if [[ "$answer" != "${answer#[Yy]}" ]]; then
      sudo pacman -S --needed git
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
  mkdir -p ~/.local/share/fonts
  cp -r $DOTFILES_DIR/misc/fonts/* ~/.local/share/fonts/
  fc-cache
}

function install_i3() {
  #TODO: add lockscren to bin folder
  mkdir -p ~/.local/bin && cp -r $DOTFILES_DIR/bin/* ~/.local/bin/ # install scripts

  sudo yay -S --needed --noconfirm i3-gaps polybar picom rofi playerctl python-pywal notify-send-py
  cp -r $DOTFILES_DIR/config/i3 ~/.config/
  cp -r $DOTFILES_DIR/config/polybar ~/.config/
  cp -r $DOTFILES_DIR/config/picom.conf ~/.config/picom.conf

  # pywal
  mkdir -p ~/.config/wal/templates/ && cp -r $DOTFILES_DIR/config/wal/templates/* ~/.config/wal/templates/
  #TODO: add dracula wallpaper here below
  wal -i ~/Pictures/wallpapers/sereneforest.jpg
  # Symlink pywal files
  ln -sf ~/.cache/wal/.Xresources ~/.Xresources

  cp -r $DOTFILES_DIR/.xinitrc ~/.xinitrc && cp -r $DOTFILES_DIR/.xprofile ~/.xprofile # install xinit and xprofile
  
  pause_function
  msg "i3-gaps) Notifications:"
  echo " 1) dunst"
  echo " 2) XFCE notifications"
  echo ""
  echo " b) BACK"
  echo ""
  read_input
  case "$OPTION" in
    1)
      sudo pacman -S --needed --noconfirm dunst
      mkdir -p ~/.config/dunst && cp -r $DOTFILES_DIR/config/dunst ~/config/
      ;;
    2)
      sudo pacman -S --needed --noconfirm xfce4-notifyd
      ;;
    "b")
      break
      ;;
    *)
      invalid_option
      ;;
  esac
}

function install_kitty() {
  sudo pacman -S --needed --noconfirm kitty
  cp -r $DOTFILES_DIR/config/kitty ~/.config/
}

function install_lunarvim() {
  bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
  cp -r $DOTFILES_DIR/config/lunarvim.lua ~/.config/lvim/config.lua
}

function install_zsh() {
  yay -S --noconfirm zsh-theme-powerlevel10k-git
  cp -r $DOTFILES_DIR/.p10k.zsh ~/.p10k.zsh
  cp -r $DOTFILES_DIR/.zshrc ~/.zshrc
}

function install_video() {
  msg "Choose your video card driver"
  echo "1) xf86-video-intel"
  echo "2) xf86-video-amdgpu" 
  echo "3) nvidia"
  echo ""
  echo " b) BACK"
  echo ""
  read_input
  case "$OPTION" in
    1)
      sudo pacman -S --needed --noconfirm xf86-video-intel
      ;;
    2)
      sudo pacman -S --needed --noconfirm xf86-video-amdgpu
      ;;
    3)
      sudo pacman -S --needed --noconfirm nvidia nvidia-settings nvidia-utils
      ;;
    "b")
      break
      ;;
    *)
      invalid_option
      ;;
  esac
}

function install_audio() {
  sudo pacman -S --needed --noconfirm pulseaudio pulseaudio-alsa pavucontrol alsa-utils alsa-plugins
}

while true; do
  msg "DOTFILES INSTALL - https://github.com/dev-math/dotfiles"
  echo " 1) Basic setup (i3-gaps, polybar, pywal, rofi and more)"
  echo " 2) Kitty"
  echo " 3) LunarVim + my config.lua"
  echo " 4) ZSH + Powerlevel10k"
  echo " 5) Video card"
  echo " 6) Audio apps"
  # Brave, Firefox, Discord, unzip, zip
  echo " 7) Development apps"
  echo " 8) Graphical tools"
  echo " 9) System apps"
  echo "10) Graphical apps"
  echo ""
  echo " q) Quit"
  echo ""
  read_input_options
  for OPT in "${OPTIONS[@]}"; do
    case "$OPT" in
      1)
        install_i3
        ;;
      2)
        install_kitty
        ;;
      3)
        install_lunarvim
        ;;
      4)
        install_zsh
        ;;
      5)
        install_video
        ;;
      6)
        install_audio
        ;;
      7)
        ;;
      "q") exit 1
      ;;
      *) echo "default"
      ;;
    esac
  done
done
