#!/usr/bin/env bash
set -e

DOTFILES_DIR=/home/$(whoami)/.dotfiles

source $DOTFILES_DIR/utils/sharedfuncs.sh

function main() {
  if ! command -v git &>/dev/null; then
    print_missing_dep_msg "git"
    exit 1
  fi

  create_dirs
  install_wallpapers
  install_scripts

  detect_platform
}

function create_dirs() {
  mkdir -p ~/Projects ~/Downloads ~/Documents ~/Desktop ~/Videos ~/Music
  mkdir -p ~/Pictures/wallpapers ~/Pictures/screenshots
}

function install_wallpapers() {
  cp -r $DOTFILES_DIR/misc/wallpaper.png ~/Pictures/wallpapers/wallpaper.png
}

function install_scripts() {
  mkdir -p ~/.local/bin && cp -r $DOTFILES_DIR/bin/* ~/.local/bin/
}

function detect_platform() {
  OS="$(uname -s)"
  case "$OS" in
    Linux)
      if [ -f "/etc/arch-release" ] || [ -f "/etc/artix-release" ]; then
        $DOTFILES_DIR/utils/install_arch.sh
      elif [ -f "/etc/fedora-release" ] || [ -f "/etc/redhat-release" ]; then
        echo "Fedora is not currently supported."
      else # assume debian based
        echo "Debian is not currently supported."
      fi
      ;;
    *)
      echo "OS $OS is not currently supported."
      exit 1
      ;;
  esac
}

main
