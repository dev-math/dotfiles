#!/usr/bin/env bash
set -e

DOTFILES_DIR=/home/$(whoami)/.dotfiles

source $DOTFILES_DIR/utils/sharedfuncs.sh

function main() {
  if ! command -v git &>/dev/null; then
    print_missing_dep_msg "git"
    exit 1
  fi

  # git clone https://github.com/dev-math/dotfiles.git $DOTFILES_DIR

  detect_platform

  create_dirs
  install_wallpapers
}

function create_dirs() {
  mkdir -p ~/Projects ~/Downloads ~/Documents ~/Desktop
  mkdir -p ~/Pictures/wallpapers ~/Pictures/screenshots
}

function install_wallpapers() {
  cp -r $DOTFILES_DIR/misc/wallpapers/* ~/Pictures/wallpapers/
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
