#!/bin/env bash
set -e

HELPER="yay"

echo "Welcome!"

read -p "Backup your files? (y/n) (default \"Yes\"): " yn
case $yn in
	n*|N*)
	echo "Backup disabled. Continuing..."
	BACKUP="no"
	;;
	y*|Y*|*)
	echo "Backup enabled. Continuing..."
	BACKUP="yes"
	;;
esac

echo "Checking some things, updating others..."
sudo pacman -Syu --noconfirm --needed base-devel git wget fontconfig xdg-user-dirs
xdg-user-dir

# install AUR helper (yay)
if ! command -v $HELPER &> /dev/null
then
    echo "It seems that you don't have $HELPER installed, I'll install that for you before continuing."
    git clone https://aur.archlinux.org/$HELPER.git
    (cd $HELPER && makepkg -si && rm -Rf $(pwd))
fi

# Install fonts
mkdir -p ~/.local/share/fonts
cp -r ./misc/fonts/* ~/.local/share/fonts/
fc-cache

# choose video card driver
echo "1) xf86-video-intel"
echo "2) xf86-video-amdgpu" 
echo "3) nvidia"
echo "4) Skip"
read -p "Choose your video card driver (default 4): " vid

case $vid in 
1)
	DRI='xf86-video-intel'
	;;
2)
	DRI='xf86-video-amdgpu'
	;;

3)
	DRI='nvidia nvidia-settings nvidia-utils'
	;;

4|*)
	DRI=""
	;;
esac

# install dependencies
yay -S --noconfirm --needed asdf-vm \
	brave-bin \
	discord \
	eog \
	feh \
	i3lock-color-git \
	kdeconnect \
	kitty \
	maim \
	man-db \
	man-pages \
	neovim \
	neofetch \
	networkmanager \
	notify-send-py \
	noto-fonts \
	noto-fonts-cjk \
	noto-fonts-emoji \
	noto-fonts-extra \
	papirus-icon-theme-git \
	pavucontrol \
	perl-file-mimeinfo \
	picom \
	playerctl \
	pulseaudio \
	pulseaudio-alsa \
	python-pip \
	python-pywal \
	python-gobject \
	qt5-tools \
	rofi \
	spotify \
	spicetify-cli \
	sshfs \
	sudo \
	texinfo \
	thunar-archive-plugin \
	thunar \
	thunar-media-tags-plugin \
	unzip \
	visual-studio-code-bin \
	wpgtk \
	xclip \
	xdg-utils \
	xorg-server \
	xorg-xinit \
	xorg-xprop \
	xorg-xrdb \
	xournalpp \
	xsettingsd \
	zathura \
	zathura-djvu \
	zathura-pdf-mupdf \
	zathura-ps \
	zathura-cb \
	zip \
	zsh \
	zsh-completions \
	$DRI

# config files

install_i3() {
	[ $BACKUP = yes ] && [ -e ~/.config/i3 ] && mv ~/.config/i3 ~/.config/i3-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
	cp -r config/i3 ~/.config/
}

install_awesome() {
	[ $BACKUP = yes ] && [ -e ~/.config/awesome ] && mv ~/.config/awesome ~/.config/awesome-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
	cp -r config/awesome ~/.config/
}

install_polybar() {
	[ $BACKUP = yes ] && [ -e ~/.config/polybar ] && mv ~/.config/polybar ~/.config/polybar-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
	cp -r config/polybar ~/.config/
}

install_dunst() {
	[ $BACKUP = yes ] && [ -e ~/.config/dunst/dunstrc ] && mv ~/.config/dunst/dunstrc ~/.config/dunst/dunstrc-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
	mkdir -p ~/.config/dunst
	ln -sf ~/.cache/wal/dunstrc ~/.config/dunst/dunstrc
}

install_xfcenotify() {
	sudo pacman -S xfce4-notifyd --needed
}

# Kitty
[ $BACKUP = yes ] && [ -e ~/.config/kitty ] && mv ~/.config/kitty ~/.config/kitty-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
cp -r config/kitty ~/.config/kitty

# Neovim
[ $BACKUP = yes ] && [ -e ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
cp -r config/nvim ~/.config/nvim


# Picom
[ $BACKUP = yes ] && [ -e ~/.config/picom.conf ] && mv ~/.config/picom.conf ~/.config/picom-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
cp -r config/picom.conf ~/.config/picom.conf

# GTK config
[ $BACKUP = yes ] && [ -e ~/.gtkrc-2.0 ] && mv ~/.gtkrc-2.0 ~/.config/.gtkrc-2.0-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
cp -r .gtkrc-2.0 ~/.gtkrc-2.0
[ $BACKUP = yes ] && [ -e ~/.config/gtk-3.0 ] && mv ~/.config/gtk-3.0 ~/.config/gtk-3.0-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
cp -r config/gtk-3.0 ~/.config/gtk-3.0

# GTK themes
if [ -e ~/.local/share/icons/WhiteSur-dark ]
then
    git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
    (cd WhiteSur-icon-theme && ./install.sh && rm -Rf $(pwd))
fi

if [ -e ~/.themes/WhiteSur-dark ]
then
    git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
    (cd WhiteSur-gtk-theme && ./install.sh && rm -Rf $(pwd))
fi

# Install xinit and xprofile
cp -r .xprofile ~/.xprofile
cp -r .xinitrc ~/.xinitrc

# Scripts
mkdir -p ~/.local/bin
cp -r bin/* ~/.local/bin/

# Wallpapers
mkdir -p ~/Pictures/wallpapers
cp -r misc/wallpapers/* ~/Pictures/wallpapers

# Pywal
mkdir -p ~/.config/wal/templates
cp -r config/wal/templates/* ~/.config/wal/templates/
# run wal to gen cache files
wal -i ~/Pictures/wallpapers
# Symlink pywal files
ln -sf ~/.cache/wal/.Xresources ~/
mkdir -p ~/.config/zathura
ln -sf ~/.cache/wal/zathurarc ~/.config/zathura/
chmod +x ~/.cache/wal/lock*
ln -sf ~/.cache/wal/lock-alpha.sh ~/.local/bin/lockscreen

# Blacklist pcspkr module
echo "blacklist pcspkr" > nobeep.conf
sudo mv nobeep.conf /etc/modprobe.d/nobeep.conf
