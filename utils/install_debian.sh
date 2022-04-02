#!/usr/bin/env bash
set -e

DOTFILES_DIR=/home/$(whoami)/.dotfiles
source $DOTFILES_DIR/utils/sharedfuncs.sh
BACKUP_FOLDER="/home/$(whoami)/BACKUP-$(date +%Y.%m.%d-%H.%M.%S)"

# Change Here {{{
BACKUP="false"

packages=(
  "autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev wget openssh-client curl apt-transport-https usbutils xclip udisks2 zip unzip unrar 7zip lzop cpio ntfs-3g dosfstools exfat-utils f2fs-tools fuse exfat-fuse jmtpfs sshfs gvfs man-db texinfo cron python3-pip" # Dependencies
  "cups system-config-printer" # Printer
  "i3-gaps feh polybar picom rofi playerctl flameshot maim" # i3gaps setup
  "dunst" # notifications | optional: xfce4-notifyd
  "rxvt-unicode zsh bat exa neofetch" # terminalf config | optional: kitty
  "brave-browser rclone qbittorrent torbrowser-launcher" # Internet apps
  "ranger" # Terminal file explorer
  "eog" # Image viewer
  "mpv mpv-mpris" # Video Player | optional: vlc
  "alsa-utils pulseaudio pavucontrol" # Audio apps
  "qalculate-gtk" # Calculator
  "zathura zathura-djvu zathura-pdf-mupdf zathura-ps zathura-cb" # PDF viewer
  "papirus-icon-theme" # Icon theme
  "kdeconnect"
  # "thunar thunar-archive-plugin thunar-media-tags-plugin" # Thunar file explorer
  # "0ad wesnoth" # Games
  # "obs-studio gucharmap xournalpp chromium-browser firefox telegram-desktop qutebrowser" # Optional
)

backup_dirs=(
  "/home/$(whoami)/.config/i3 $DOTFILES_DIR/config/i3 $DOTFILES_DIR/"
  "/home/$(whoami)/.config/polybar $DOTFILES_DIR/config/polybar"
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
#}}}

function backup() {
  if [[ $BACKUP = "false" ]]; then
    rm -Rf "$1"
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
  sudo add-apt-repository -y ppa:regolith-linux/release # add i3gaps
  # Lunar Vim
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  # Brave
  sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
  # zathura mupdf
  sudo add-apt-repository -y ppa:spvkgn/zathura-mupdf

  sudo apt update -y && sudo apt upgrade -y
}

function check_system_deps() {
  msg "Checking some things..."
  sudo apt install -y build-essential flatpak

  if ! command -v git &>/dev/null; then
    msg "It seems that you don't have git installed. Would you like to install?"
    read -p "[y]es or [n]o (default: no) : " -r answer
    if [[ "$answer" != "${answer#[Yy]}" ]]; then
      sudo apt install -y git
    else
      print_missing_dep_msg "git"
      exit 1
    fi
  fi
}

function install_fonts() {
  sudo apt install -y fonts-noto fonts-noto-cjk fonts-noto-color-emoji fonts-noto-extra fontconfig
  mkdir -p ~/.local/share/fonts
  cp -r $DOTFILES_DIR/misc/fonts/* ~/.local/share/fonts/
  fc-cache
}

function install_base() {
  msg "Installing apps that I use..."
  # install i3lock-color
  cd /tmp
  git clone https://github.com/Raymo111/i3lock-color.git && cd i3lock-color
  ./install-i3lock-color.sh
  cd $DOTFILES_DIR
  sudo apt install -y ${packages[@]}

  if [ ! -e ~/.local/bin/lvim ]; then
    msg "Installing Lunar Vim"
    sudo apt install -y yarn rustc
    bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
  fi

  msg "Installing discord"
  flatpak install flathub com.discordapp.Discord

  msg "Installing kotatogram"
  flatpak install flathub io.github.kotatogram

  msg "Installing Obsidian"
  flatpak install flathub md.obsidian.Obsidian

  msg "Installing asdf"
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.9.0
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

  chsh -s $(which zsh) # change shell to zsh for the current user

  cp -r $DOTFILES_DIR/config/cronjobs ~/.config/cronjobs
  crontab -l >> ~/.config/cronjobs
  crontab ~/.config/cronjobs
}

function config_pywal() {
  sudo pip3 install pywal
  mkdir -p ~/.config/wal/templates/ 
  cp -r $DOTFILES_DIR/config/wal/templates/* ~/.config/wal/templates/
  wal -i ~/Pictures/wallpapers/wallpaper.png -e -s -t -q -n -o ~/.local/bin/afterwal
  # Symlink pywal files
  sed -i "s/math/$(whoami)/g" ~/.config/wal/templates/flameshot.ini
  backup "~/.config/flameshot" && mkdir -p ~/.config/flameshot && ln -sf ~/.cache/wal/flameshot ~/.config/flameshot/flameshot.ini
  backup "~/.config/zathura" && mkdir -p ~/.config/zathura && ln -sf ~/.cache/wal/zathurarc ~/.config/zathura/zathurarc
  backup "~/.config/dunst" && mkdir -p ~/.config/dunst && ln -sf ~/.cache/wal/dunstrc ~/.config/dunst/dunstrc
  backup "~/.Xresources" && ln -sf ~/.cache/wal/Xresources ~/.Xresources
}

function install_whitesur() {
  cd /tmp
  git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
  (cd WhiteSur-icon-theme && ./install.sh)
  cd /tmp
  git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
  (cd WhiteSur-gtk-theme && ./install.sh) 
  cd $DOTFILES_DIR

  cat <<EOF > ~/.gtkrc-2.0
gtk-theme-name="WhiteSur-dark"
gtk-icon-theme-name="WhiteSur-dark"
EOF

  cat <<EOF > ~/.config/gtk-3.0/settings.ini
gtk-theme-name=WhiteSur-dark
gtk-icon-theme-name=WhiteSur-dark
EOF
}

function config_xfce4notifyd() {
  # check is working
  cat <<EOF > ~/.xprofile

  # Start notifications
  /usr/lib/xfce4/notifyd/xfce4-notifyd &
EOF
  sed -i "s/refreshDunst/refreshXfceNotify/g" ~/.config/polybar/modules.ini
  sed -i "s/toggleDunst/toggleXfceNotify/g" ~/.config/polybar/modules.ini
}

system_update
check_system_deps
install_fonts
install_base
config_base
config_pywal
install_whitesur

clear
echo "Done."
echo "Reboot the system."
