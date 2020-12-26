#!/bin/bash

echo -n "Delete existing files (y/n)?"
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
	rm -Rf /etc/X11/xorg.conf.d/30-touchpad.conf
	rm -Rf ~/.config/awesome
	rm -Rf ~/.config/i3
	rm -Rf ~/.config/gtk-3.0
	rm -Rf ~/.config/picom.conf
	rm -Rf ~/.config/polybar
	rm -Rf ~/.config/ranger
	rm -Rf ~/.config/spicetify/Themes/wal
	rm -Rf ~/.config/wal/templates
	rm -Rf ~/.gtkrc-2.0
	rm -Rf ~/.local/share/fonts
	rm -Rf ~/.Xresources
	rm -Rf ~/.zshrc
	rm -Rf ~/Pictures/Wallpapers
else
	echo "OK, continuing..."
fi

mkdir -p ~/.config/wal
mkdir -p ~/.themes
mkdir -p ~/Pictures/screenshots

ln -s ~/.dotfiles/.config/awesome ~/.config/awesome
ln -s ~/.dotfiles/.config/gtk-3.0 ~/.config/gtk-3.0
ln -s ~/.dotfiles/.config/i3 ~/.config/i3
ln -s ~/.dotfiles/.config/picom.conf ~/.config/picom.conf
ln -s ~/.dotfiles/.config/polybar ~/.config/polybar
ln -s ~/.dotfiles/.config/ranger ~/.config/ranger
ln -s ~/.dotfiles/.config/spicetify/Themes/wal ~/.config/spicetify/Themes/wal
ln -s ~/.dotfiles/.config/wal/templates ~/.config/wal/templates
ln -s ~/.dotfiles/.gtkrc-2.0 ~/.gtkrc-2.0
ln -s ~/.dotfiles/misc/fonts ~/.local/share/fonts
ln -s ~/.dotfiles/.Xresources ~/.Xresources
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/Wallpapers ~/Pictures/Wallpapers

fc-cache -v

# Install spicetify theme
spicetify config current_theme wal
spicetify apply

# Install touchpad custom config
ln -s ~/.dotfiles/misc/30-touchpad.conf /etc/X11/xorg.conf.d/30-touchpad.conf

echo "Done."
