#!/usr/bin/env bash
set -e

# Define the list of packages to be installed
packages=(
  "wget openssh curl usbutils xclip udisks2 udiskie zip unzip unrar p7zip lzop cpio ntfs-3g dosfstools exfat-utils f2fs-tools fuse fuse-exfat mtpfs sshfs gvfs man-db man-pages texinfo networkmanager maim xorg-xrandr xorg-server xorg-xgamma xorg-xinit cronie parcellite libappindicator-gtk3" # Base
  "cups system-config-printer" # Printer
  "i3-gaps polybar picom rofi playerctl python-pywal flameshot-git xdg-desktop-portal xdg-desktop-portal-wlr" # i3gaps setup
  "dunst" # notifications | optional: xfce4-notifyd
  "alacritty zsh bat exa neofetch tmux fd ripgrep" # terminal config | optional: kitty rxvt-unicode
  "firefox brave-bin rclone qbittorrent torbrowser-launcher obs-studio" # Internet apps
  "obsidian" # note taking
  "discord telegram-desktop" # chat apps | optional: kotatogram-desktop
  "feh" # Image viewer | optional: eog
  "mpv mpv-mpris" # Video Player | optional: vlc
  "alsa-utils alsa-plugins pavucontrol pipewire wireplumber pipewire-alsa pipewire-pulse pipewire-jack" # Audio apps
  "bluez bluez-utils" # bluetooth
  "qalculate-gtk" # Calculator
  "zathura zathura-djvu zathura-pdf-mupdf zathura-ps zathura-cb" # PDF viewer
  "papirus-icon-theme-git" # Icon theme
  "light redshift autorandr arandr" # screen
  "kdeconnect"
  "noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra fontconfig" # fonts
  "thunar thunar-archive-plugin thunar-media-tags-plugin" # Thunar file explorer
  "mesa mesa-utils libva-mesa-driver vkd3d lib32-vkd3d"
  "lutris wine lib32-gamemode gamemode steam" # Games | optional: 0ad wesnoth
  # "xf86-video-amdgpu" # AMD GPU
  # "nvidia nvidia-utils nvidia-settings" # Nvidia GPU
  # "gucharmap xournalpp chromium google-chrome qutebrowser" # Optional
  # "ranger" # Terminal file explorer
)

# Define variables
DOTFILES_DIR=/home/$(whoami)/.dotfiles
noconfirm=false
install_flags=("-S" "--needed")

# Define the list of dotfiles to install
dotfiles=(
  "/home/$(whoami)/.config/cronjobs $DOTFILES_DIR/config/cronjobs"
  "/home/$(whoami)/.config/i3 $DOTFILES_DIR/config/i3"
  "/home/$(whoami)/.config/polybar $DOTFILES_DIR/config/polybar"
  "/home/$(whoami)/.config/alacritty $DOTFILES_DIR/config/alacritty"
  "/home/$(whoami)/.config/nvim $DOTFILES_DIR/config/nvim"
  "/home/$(whoami)/.config/mimeapps.list $DOTFILES_DIR/config/mimeapps.list"
  "/home/$(whoami)/.config/picom.conf $DOTFILES_DIR/config/picom.conf"
  "/home/$(whoami)/.config/tmux $DOTFILES_DIR/config/tmux"
  "/home/$(whoami)/.config/autorandr $DOTFILES_DIR/config/autorandr"
  "/home/$(whoami)/.config/gtk-3.0 $DOTFILES_DIR/config/gtk-3.0"
  "/home/$(whoami)/.gtkrc-2.0 $DOTFILES_DIR/gtkrc-2.0"
  "/home/$(whoami)/.config/zsh $DOTFILES_DIR/config/zsh"
  "/home/$(whoami)/.xinitrc $DOTFILES_DIR/xinitrc"
  "/home/$(whoami)/.xprofile $DOTFILES_DIR/xprofile"
)

# Parse arguments
for arg in "$@"; do
  case $arg in
    --noconfirm)
      noconfirm=true
      install_flags+=("--noconfirm")
      ;;
    *)
      echo "Invalid option: -$arg" >&2
      echo "Script usage:" >&2
      echo "--noconfirm         -- Do not ask for confirmation"
      exit 1
      ;;
  esac
done

function backup() {
  # Backup or Remove the file/dir
  target="$1"
  if [ "${backup_files:-}" == "y" ]; then
    backup_file="${target}_backup"
    echo "Backing up $target to $backup_file"
    mv "$target" "$backup_file"
  else
    rm -Rf "$target"
  fi
}

## enable multilib rep
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

## enable sudo
sed -i '/%wheel\ ALL=(ALL)\ ALL/s/^#//' /etc/sudoers

## add user to groups
usermod -m -G wheel,video $(whoami)

## create default dirs
mkdir -p ~/Projects ~/Downloads ~/Documents/Books ~/Desktop ~/Videos ~/Music
mkdir -p ~/Documents/Notes
# ln -sf ~/Documents/Books/ ~/Documents/Notes/0.1\ Assets/Books
mkdir -p ~/Pictures/wallpapers ~/Pictures/screenshots

## copy default wallpaper
cp -r $DOTFILES_DIR/misc/wallpaper.png ~/Pictures/wallpapers/dracula.png

## install custom scripts
mkdir -p ~/.local/bin && cp -r $DOTFILES_DIR/bin/* ~/.local/bin/

# Install required pkgs
sudo pacman -Sy --noconfirm --needed archlinux-keyring && sudo pacman -Su --noconfirm --needed
sudo pacman -S --noconfirm --needed flatpak git base-devel

# Update the system
sudo pacman -Syyuu --noconfirm --needed

# Check if yay is installed and install if necessary
if ! command -v yay &> /dev/null; then
  if [ "$noconfirm" = false ]; then
    read -p "Yay is not installed, do you want to install it? (y/n) " -r REPLY
    if [[ $REPLY =~ ^[Nn]$ ]]; then
      echo "Yay is required for this script. Exiting."
      exit 1
    fi
  fi

  echo "Installing yay..."
  sudo pacman "${install_flags[@]}" git base-devel
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
  cd ..
  rm -rf yay
fi

# Install packages with yay
echo "Installing packages with yay..."
yay "${install_flags[@]}" "${packages[@]}"

# Prompt the user to backup dotfiles
backup_files="n"
if [ "$noconfirm" = false ]; then
  read -p "Do you want to backup your current dotfiles? (y/N) " -r REPLY
  if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    backup_files="y"
  fi
fi

# Backup and install dotfiles
for file in "${dotfiles[@]}"
do
  target=$(echo "$file" | cut -d' ' -f1)
  source=$(echo "$file" | cut -d' ' -f2)

  # Backup or Remove the file/dir
  if [[ -e "$target" ]]; then
    backup "$target"
  fi

  mkdir -p "$(dirname "$target")"
  ln -sf "$source" "$target"
done

# Install custom fonts
mkdir -p ~/.local/share/fonts
cp -r $DOTFILES_DIR/misc/fonts/* ~/.local/share/fonts/
fc-cache

# Install i3-lock
if ! command -v i3lock &>/dev/null; then
  cd /tmp
  git clone https://github.com/Raymo111/i3lock-color.git && cd i3lock-color
  ./install-i3lock-color.sh
  cd $DOTFILES_DIR
  rm -Rf /tmp/i3lock-color
fi

# Install ASDF
if ! command -v asdf &> /dev/null
then
  if [[ ! -d $HOME/.asdf ]]; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.3
    source "$HOME/.asdf/asdf.sh"
  fi
fi

# Install Node.js
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs lts
asdf global nodejs lts
npm i -g vscode-langservers-extracted @fsouza/prettierd

# Install WhiteSur theme
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
(cd WhiteSur-icon-theme && ./install.sh && cd .. && rm -Rf WhiteSur-icon-theme)
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
(cd WhiteSur-gtk-theme && ./install.sh && ./tweaks.sh -f alt && cd .. && rm -Rf WhiteSur-gtk-theme)

# Install Thermald and Intel-ucode on Intel CPU
if [[ $(grep -m 1 'vendor_id' /proc/cpuinfo | grep -i 'Intel') ]]; then
  yay "${install_flags[@]}" thermald intel-ucode
  sudo systemctl enable --now thermald
else
  yay "${install_flags[@]}" amd-ucode
fi
# Activate loading the microcode update
sudo grub-mkconfig -o /boot/grub/grub.cfg

# enable pipewire
systemctl --user enable --now pipewire-pulse.service

# Check for the presence of a battery
if [ -d "/sys/class/power_supply" ]; then
  yay "${install_flags[@]}" tlp
  # install and enable tlp for battery power saving
  systemctl enable --now tlp.service
  systemctl mask systemd-rfkill.service
  systemctl mask systemd-rfkill.socket
  sudo tlp start
fi

# Check Video Chipset
_vga=$(lspci | grep VGA | tr "[:upper:]" "[:lower:]")
_vga_length=$(lspci | grep VGA | wc -l)
if [[ $_vga_length -eq 2 ]] && [[ -n $(echo "${_vga}" | grep "nvidia") || -f /sys/kernel/debug/dri/0/vbios.rom ]]; then
  VIDEO_DRIVER="optimus"
elif [[ -n $(echo "${_vga}" | grep "nvidia") || -f /sys/kernel/debug/dri/0/vbios.rom ]]; then
  VIDEO_DRIVER="nvidia"
elif [[ -n $(echo "${_vga}" | grep "advanced micro devices") || -f /sys/kernel/debug/dri/0/radeon_pm_info || -f /sys/kernel/debug/dri/0/radeon_sa_info ]]; then
  VIDEO_DRIVER="amdgpu"
elif [[ -n $(echo "${_vga}" | grep "intel corporation") || -f /sys/kernel/debug/dri/0/i915_capabilities ]]; then
  VIDEO_DRIVER="intel"
else
  VIDEO_DRIVER="vesa"
fi
if [[ $noconfirm = false ]] && [[ $VIDEO_DRIVER == intel || $VIDEO_DRIVER == vesa ]]; then
  read -p "Confirm video driver: $VIDEO_DRIVER [Y/n]" OPTION
  if [[ $OPTION == n ]]; then
    printf "%s" "Type your video driver [ex: sis, fbdev, modesetting]: "
    read -r VIDEO_DRIVER
  fi
fi

# Install Video Card
if [[ ${VIDEO_DRIVER} == intel ]]; then
  yay "${install_flags[@]}" "xf86-video-${VIDEO_DRIVER} mesa-libgl libvdpau-va-gl libva-intel-driver"
else
  yay "${install_flags[@]}" "xf86-video-${VIDEO_DRIVER} mesa-libgl libvdpau-va-gl"
fi

# Configure and enable cronjobs
sed -i "s/math/$(whoami)/g" ~/.config/cronjobs
crontab -l >> ~/.config/cronjobs
crontab ~/.config/cronjobs
systemctl enable --now cronie

# Install ZSH
cat << 'EOF' >| ~/.zshenv
export ZDOTDIR=~/.config/zsh
[[ -f $ZDOTDIR/.zshenv ]] && . $ZDOTDIR/.zshenv
EOF
chsh -s $(which zsh) # change shell to zsh for the current user

# Blacklist PC speaker module
echo "blacklist pcspkr" | sudo tee /etc/modprobe.d/nobeep.conf

# Configure keyboard and touchpad
sudo ln -sf $DOTFILES_DIR/config/00-keyboard.conf /etc/X11/xorg.conf.d/00-keyboard.conf
sudo ln -sf $DOTFILES_DIR/config/30-touchpad.conf /etc/X11/xorg.conf.d/30-touchpad.conf

# Configure pywal files
mkdir -p ~/.config/wal/templates/ 
ln -sf $DOTFILES_DIR/config/wal/templates/* ~/.config/wal/templates/
wal -i ~/Pictures/wallpapers/dracula.png -e -s -t -q -n -o ~/.local/bin/afterwal
# Symlink pywal files
sed -i "s/math/$(whoami)/g" ~/.config/wal/templates/flameshot.ini
backup "~/.config/flameshot" && mkdir -p ~/.config/flameshot && ln -sf ~/.cache/wal/flameshot ~/.config/flameshot/flameshot.ini
backup "~/.config/zathura" && mkdir -p ~/.config/zathura && ln -sf ~/.cache/wal/zathurarc ~/.config/zathura/zathurarc
backup "~/.config/dunst" && mkdir -p ~/.config/dunst && ln -sf ~/.cache/wal/dunstrc ~/.config/dunst/dunstrc
backup "~/.Xresources" && ln -sf ~/.cache/wal/Xresources ~/.Xresources

# Configure hp p1102w printer
install_hp="y"
if [ "$noconfirm" = false ]; then
  read -p "Do you want to configure HP LaserJet P1102 printer? (y/N) " -r REPLY
  if [[ "$REPLY" =~ ^[Nn]$ ]]; then
    install_hp="n"
  fi
fi
if [ "${install_hp:-}" == "y" ]; then
  yay "${install_flags[@]}" hplip hplip-plugin
fi
