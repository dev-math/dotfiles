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

function system_update() {
  msg "Checking some things, updating others..."
  sudo pacman -Syyuu --noconfirm 
}

function check_system_deps() {
  msg "Can I update your system and install some essential packages? 👉👈"
  read -p "[y]es or [n]o (default: no) : " -r answer
  [ "$answer" != "${answer#[Yy]}" ] && system_update && sudo pacman -S --noconfirm --needed base-devel fontconfig

  if ! command -v git &>/dev/null; then
    msg "It seems that you don't have git installed. Would you like to install git?"
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
    msg "It seems that you don't have yay installed. Would you like to install yay?"
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

function install_i3() {
  sudo pacman -S --needed --noconfirm i3-gaps
  cp -r config/i3 ~/.config/

  install_misc_apps "i3"
  install_themes "i3"
  config_xinitrc "i3"
  pause_function
  while true; do
    msg "i3-GAPS CUSTOMIZATION"
    echo " 1) polybar"
    echo " 2) XFCE notifications"
    echo " 3) dunst"
    echo ""
    echo " d) DONE"
    echo ""
    read_input_options
    for OPT in "${OPTIONS[@]}"; do
      case "$OPT" in
        1)
          yay -S --needed --noconfirm polybar
          cp -r config/polybar ~/.config/
          ;;
        2)
          sudo pacman -S --needed --noconfirm xfce4-notifyd
          ;;
        3)
          sudo pacman -S --needed --noconfirm dunst
          mkdir -p ~/.config/dunst
          cp -r config/dunst ~/config/
          ln -sf ~/.cache/wal/dunstrc ~/.config/dunst/dunstrc
          ;;
        "d")
          break
          ;;
        *)
          invalid_option
          ;;
      esac
    done
  done
}

while true; do
  msg "DOTFILES INSTALL - https://github.com/dev-math/dotfiles"
  echo " 1) i3-gaps"
  echo " 2) Rofi"
  echo " 3) Pywal"
  echo " 4) Kitty"
  echo " 5) LunarVim + my config.lua"
  echo " 6) ZSH + Powerlevel10k"
  echo " 7) Others (xprofile, xresources, scripts and wallpapers)"
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
        echo 2
        ;;
      3)
        echo 3
        ;;
      4)
        echo 4
        ;;
      5)
        echo 5
        ;;
      6)
        echo 6
        ;;
      "q") exit 1
      ;;
      *) echo "default"
      ;;
    esac
    
  done
done
