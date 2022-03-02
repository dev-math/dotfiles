#!/usr/bin/env bash
set -e

DOTFILES_DIR=/home/$(whoami)/.dotfiles

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
source $DOTFILES_DIR/utils/sharedfuncs.sh

function main() {
  msg "Tip: script can be cancelled at any time with CTRL+C"

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
  system_update

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
      yay -S --noconfirm --needed 7-zip
    else
      print_missing_dep_msg "yay"
      exit 1
    fi
  fi

  msg "I will install some essential packages. Ok? 👉👈"
  read -p "[y]es or [n]o (default: no) : " -r answer
  [ "$answer" != "${answer#[Yy]}" ] && system_update && sudo pacman -S --noconfirm --needed base-devel xclip udisks2 udiskie zip unzip unrar lzop cpio ntfs-3g dosfstools exfat-utils f2fs-tools fuse fuse-exfat mtpfs sshfs gvfs man-db man-pages texinfo networkmanager maim xorg-server xorg-xinit
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

function install_i3() {
  mkdir -p ~/.local/bin && cp -r $DOTFILES_DIR/bin/* ~/.local/bin/ # install scripts

  yay -S --needed --noconfirm i3-gaps i3lock-color-git feh polybar picom rofi playerctl python-pywal flameshot
  mkdir -p ~/.config/i3 && cp -r $DOTFILES_DIR/config/i3/* ~/.config/i3/
  mkdir -p ~/.config/polybar && cp -r $DOTFILES_DIR/config/polybar/* ~/.config/polybar/
  cp -r $DOTFILES_DIR/config/picom.conf ~/.config/picom.conf
  cp -r $DOTFILES_DIR/xinitrc ~/.xinitrc && cp -r $DOTFILES_DIR/xprofile ~/.xprofile # install xinit and xprofile

  # pywal
  mkdir -p ~/.config/wal/templates/ && cp -r $DOTFILES_DIR/config/wal/templates/* ~/.config/wal/templates/
  wal -i ~/Pictures/wallpapers/sereneforest.jpg -e -s -t -q -n
  # Symlink pywal files
  ln -sf ~/.cache/wal/Xresources ~/.Xresources
  sed -i "s/math/$(whoami)/g" ~/.config/wal/templates/flameshot.ini
  mkdir -p ~/.config/flameshot && ln -sf ~/.cache/wal/flameshot ~/.config/flameshot/flameshot.ini

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
      mkdir -p ~/.config/dunst && ln -sf ~/.cache/wal/dunstrc ~/.config/dunstrc
      ;;
    2)
      sudo pacman -S --needed --noconfirm xfce4-notifyd
      echo "" >> ~/.xprofile
      echo "# Start notifications" >> ~/.xprofile
      echo "/usr/lib/xfce4/notifyd/xfce4-notifyd &" >> ~/.xprofile
      sed -i "s/refreshDunst/refreshXfceNotify/g" ~/.config/polybar/modules.ini
      sed -i "s/toggleDunst/toggleXfceNotify/g" ~/.config/polybar/modules.ini
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
  mkdir -p ~/.config/kitty && cp -r $DOTFILES_DIR/config/kitty/* ~/.config/kitty/
}

function install_lunarvim() {
  sudo pacman -S --noconfirm --needed yarn rust
  if ! command -v lvim &> /dev/null
  then
    bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
  fi
  cp -r $DOTFILES_DIR/config/lunarvim.lua ~/.config/lvim/config.lua
}

function install_zsh() {
  yay -S --noconfirm --needed zsh neofetch bat exa
  mkdir -p ~/.zsh && cp -r $DOTFILES_DIR/zsh/* ~/.zsh/
  mv ~/.zsh/p10k.zsh ~/.p10k.zsh
  cp -r $DOTFILES_DIR/zshrc ~/.zshrc
  [ ! -e ~/.asdf ] && git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.9.0 # install asdf
  chsh -s $(which zsh) # change default shell to zsh
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
  sudo pacman -S --needed --noconfirm pulseaudio pulseaudio-alsa alsa-utils alsa-plugins

  msg "Install VLC? 👉👈"
  read -p "[y]es or [n]o (default: no) : " -r answer
  [ "$answer" != "${answer#[Yy]}" ] && system_update && sudo pacman -S --noconfirm --needed vlc

  msg "Install Pavucontrol? 👉👈"
  read -p "[y]es or [n]o (default: no) : " -r answer
  [ "$answer" != "${answer#[Yy]}" ] && system_update && sudo pacman -S --noconfirm --needed pavucontrol
}

function install_internet() {
  while true; do
    msg "INTERNET APPS"
    echo " 1) Brave"
    echo " 2) Chromium"
    echo " 3) Google Chrome"
    echo " 4) Firefox"
    echo " 5) Discord"
    echo " 6) Telegram"
    echo " 7) qbittorrent"
    echo " 8) google-drive-ocamlfuse"
    echo " 9) Tor browser"
    echo "10) qutebrowser"
    echo ""
    echo " b) BACK"
    echo ""
    read_input_options
    for OPT in "${OPTIONS[@]}"; do
      case "$OPT" in
        1)
          yay -S --noconfirm --needed brave-bin
          ;;
        2)
          sudo pacman -S --noconfirm --needed chromium
          ;;
        3)
          yay -S --noconfirm --needed google-chrome
          ;;
        4)
          sudo pacman -S --noconfirm --needed firefox
          ;;
        5)
          sudo pacman -S --noconfirm --needed discord
          ;;
        6)
          sudo pacman -S --noconfirm --needed telegram-desktop flatpak
          flatpak install flathub io.github.kotatogram
          ;;
        7)
          sudo pacman -S --noconfirm --needed qbittorrent
          ;;
        8)
          yay -S --noconfirm --needed google-drive-ocamlfuse
          ;;
        9)
          sudo pacman -S --noconfirm --needed torbrowser-launcher
          ;;
        10)
          sudo pacman -S --noconfirm --needed qutebrowser
          ;;
        "b")
          break
          ;;
        *)
          invalid_option
          ;;
      esac
    done
  done
}

function install_gtk() {
  cp -r $DOTFILES_DIR/gtkrc-2.0 ~/.gtkrc-2.0
  mkdir -p ~/.config/gtk-3.0 && cp -r $DOTFILES_DIR/config/gtk-3.0/* ~/.config/gtk-3.0/
}

function install_other() {
  while true; do
    msg "Other tools and apps"
    echo " 1) 🎮 0ad                         11) Qalculate"
    echo " 2) 🎮 Wesnoth                     12) Papirus Icon theme"
    echo " 3) Obs Studio                     13) Blacklist pcspkr module"
    echo " 4) KDE Connect                    14) WhiteSur theme"
    echo " 5) Thunar                         15) Obsidian"
    echo " 6) Ranger"
    echo " 7) Zathura"
    echo " 8) Xournal++                       b) BACK"
    echo " 9) eog (Image Viewer)"
    echo "10) Gucharmap"
    read_input_options
    for OPT in "${OPTIONS[@]}"; do
      case "$OPT" in
        1)
          sudo pacman -S --needed --noconfirm 0ad
          ;;
        2)
          sudo pacman -S --needed --noconfirm wesnoth
          ;;
        3)
          sudo pacman -S --needed --noconfirm obs-studio
          ;;
        4)
          sudo pacman -S --needed --noconfirm kdeconnect
          ;;
        5)
          sudo pacman -S --needed --noconfirm thunar thunar-archive-plugin thunar-media-tags-plugin
          ;;
        6)
          sudo pacman -S --needed --noconfirm ranger
          ;;
        7)
          sudo pacman -S --needed --noconfirm zathura zathura-djvu zathura-pdf-mupdf zathura-ps zathura-cb
          if command -v wal &> /dev/null
          then
            mkdir -p ~/.config/zathura
            ln -sf ~/.cache/wal/zathurarc ~/.config/zathura/zathurarc
          fi
          ;;
        8)
          sudo pacman -S --needed --noconfirm xournalpp
          ;;
        9)
          sudo pacman -S --needed --noconfirm eog
          ;;
        10)
          sudo pacman -S --needed --noconfirm gucharmap
          ;;
        11)
          sudo pacman -S --needed --noconfirm qalculate-gtk
          ;;
        12)
          yay -S --needed --noconfirm papirus-icon-theme-git
          ;;
        13)
          echo "blacklist pcspkr" > nobeep.conf
          sudo mv nobeep.conf /etc/modprobe.d/nobeep.conf
          ;;
        14)
          install_gtk
          git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
          (cd WhiteSur-icon-theme && ./install.sh && rm -Rf $(pwd))
          git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
          (cd WhiteSur-gtk-theme && ./install.sh && rm -Rf $(pwd))
          echo 'gtk-theme-name="WhiteSur-dark"' >> ~/.gtkrc-2.0
          echo 'gtk-icon-theme-name="WhiteSur-dark"' >> ~/.gtkrc-2.0
          echo 'gtk-theme-name=WhiteSur-dark' >> ~/.config/gtk-3.0/settings.ini
          echo 'gtk-icon-theme-name=WhiteSur-dark' >> ~/.config/gtk-3.0/settings.ini
          echo "Done."
          ;;
        15)
          sudo pacman -S --needed --noconfirm flatpak
          flatpak install flathub md.obsidian.Obsidian
          ;;
        "b")
          break
          ;;
        16)
          break
          ;;
        *)
          invalid_option
          ;;
      esac
    done
  done
}

main

while true; do
  msg "DOTFILES INSTALL - https://github.com/dev-math/dotfiles"
  echo " 1) Basic setup (i3-gaps, polybar, pywal, rofi and more)"
  echo " 2) Kitty"
  echo " 3) LunarVim + my config.lua"
  echo " 4) ZSH + Powerlevel10k"
  echo " 5) Video card"
  echo " 6) Audio apps"
  echo " 7) Internet apps"
  echo " 8) Other tools and apps"
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
        install_internet
        ;;
      8)
        install_other
        ;;
      "q")
        exit 1
        ;;
      *) echo "Try again" #TODO: fix that
      ;;
    esac
  done
done
