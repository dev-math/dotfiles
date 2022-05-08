#!/usr/bin/env bash
set -e

DOTFILES_DIR=/home/$(whoami)/.dotfiles
source $DOTFILES_DIR/utils/sharedfuncs.sh
BACKUP_FOLDER="/home/$(whoami)/BACKUP-$(date +%Y.%m.%d-%H.%M.%S)"

# Change Here {{{
BACKUP="false"

packages=(
  "wget openssh curl usbutils xclip udisks2 udiskie zip unzip unrar p7zip lzop cpio ntfs-3g dosfstools exfat-utils f2fs-tools fuse fuse-exfat mtpfs sshfs gvfs man-db man-pages texinfo networkmanager maim xorg-xrandr xorg-server xorg-xinit cronie parcellite" # Base
  "cups system-config-printer" # Printer
  "i3-gaps feh polybar picom rofi playerctl python-pywal flameshot" # i3gaps setup
  "dunst" # notifications | optional: xfce4-notifyd
  "alacritty zsh bat exa neofetch" # terminal config | optional: kitty rxvt-unicode
  "firefox brave-bin rclone qbittorrent torbrowser-launcher" # Internet apps
  "eog" # Image viewer
  "mpv mpv-mpris" # Video Player | optional: vlc
  "alsa-utils alsa-plugins pulseaudio pulseaudio-alsa pavucontrol" # Audio apps
  "qalculate-gtk" # Calculator
  "zathura zathura-djvu zathura-pdf-mupdf zathura-ps zathura-cb" # PDF viewer
  "papirus-icon-theme-git" # Icon theme
  "kdeconnect"
  "bluez bluez-utils pulseaudio-bluetooth" # bluetooth
  "thunar thunar-archive-plugin thunar-media-tags-plugin" # Thunar file explorer
  "mesa mesa-utils libva-mesa-driver"
  "xf86-video-intel libva-intel-driver" # Intel GPU
  # "xf86-video-amdgpu" # AMD GPU
  # "nvidia nvidia-utils nvidia-settings" # Nvidia GPU
  # "obs-studio gucharmap xournalpp chromium google-chrome telegram-desktop qutebrowser" # Optional
  # "0ad wesnoth" # Games
  # "ranger" # Terminal file explorer
)

backup_dirs=(
  "/home/$(whoami)/.config/i3 $DOTFILES_DIR/config/i3 $DOTFILES_DIR/"
  "/home/$(whoami)/.config/polybar $DOTFILES_DIR/config/polybar"
  # "/home/$(whoami)/.config/kitty $DOTFILES_DIR/config/kitty"
  "/home/$(whoami)/.config/alacritty $DOTFILES_DIR/config/alacritty"
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

function install_base() {
  msg "Installing apps that I use..."
  # install i3lock-color
  if ! command -v i3lock &>/dev/null; then
    cd /tmp
    git clone https://github.com/Raymo111/i3lock-color.git && cd i3lock-color
    ./install-i3lock-color.sh
    cd $DOTFILES_DIR
    rm -Rf /tmp/i3lock-color
  fi

  yay -S --needed --noconfirm ${packages[@]}

  if [ ! -e ~/.local/bin/lvim ]; then
    msg "Installing Lunar Vim"
    yay -S --needed --noconfirm yarn rust
    bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
  fi

  msg "Installing discord"
  flatpak install flathub com.discordapp.Discord

  msg "Installing kotatogram"
  flatpak install flathub io.github.kotatogram

  msg "Installing Obsidian"
  flatpak install flathub md.obsidian.Obsidian

  msg "Installing asdf"
  if ! command -v asdf &> /dev/null
  then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.9.0
  fi
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

  # mkdir -p ~/.urxvt/ext && cp -r $DOTFILES_DIR/urxvt/* ~/.urxvt/ext/ # Install URxvt perl extensions
  # config_xfce4notifyd

  chsh -s $(which zsh) # change shell to zsh for the current user

  # Blacklist PC speaker module
  echo "blacklist pcspkr" > nobeep.conf
  sudo mv nobeep.conf /etc/modprobe.d/nobeep.conf

  # Set keyboard layout
  sudo cp -r $DOTFILES_DIR/config/00-keyboard.conf /etc/X11/xorg.conf.d/00-keyboard.conf

  cp -r $DOTFILES_DIR/config/cronjobs ~/.config/cronjobs
  crontab -l >> ~/.config/cronjobs
  crontab ~/.config/cronjobs
}

function config_pywal() {
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
  git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
  (cd WhiteSur-icon-theme && ./install.sh && rm -Rf $(pwd))
  git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
  (cd WhiteSur-gtk-theme && ./install.sh && rm -Rf $(pwd))
}

function config_xfce4notifyd() {
cat <<EOF >> ~/.xprofile

# Start notifications
/usr/lib/xfce4/notifyd/xfce4-notifyd &
EOF
  sed -i "s/refreshDunst/refreshXfceNotify/g" ~/.config/polybar/modules.ini
  sed -i "s/toggleDunst/toggleXfceNotify/g" ~/.config/polybar/modules.ini
}

function config_hp_printer() {
  yay -S --needed --noconfirm hplip hplip-plugin
}

system_update
check_system_deps
install_fonts
install_base
config_pywal
config_base
# config_hp_printer
install_whitesur

clear
echo "Done."
echo "Reboot the system."
