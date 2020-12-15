#!/bin/bash

echo -n "Delete existing files (y/n)?"
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
	rm -Rf ~/.config/awesome
	rm -Rf ~/.config/i3/config
	rm -Rf ~/.config/gtk-3.0/settings.ini
	rm -Rf ~/.config/picom.conf
	rm -Rf ~/.config/polybar/config
	rm -Rf ~/.config/spicetify/Themes/wal
	rm -Rf ~/.config/wal/templates
	rm -Rf ~/.local/share/fonts
	rm -Rf ~/.Xresources
	rm -Rf ~/.zshrc
	rm -Rf ~/Pictures/Wallpapers
else
	echo "OK, continuing..."
fi

mkdir -p ~/.config/i3
mkdir -p ~/.config/polybar
mkdir -p ~/.config/rofi
mkdir -p ~/.config/wal
mkdir -p ~/.config/zathura
mkdir -p ~/.cache/wal
mkdir -p ~/Pictures/screenshots

ln -s ~/.dotfiles/.config/awesome ~/.config/awesome
ln -s ~/.dotfiles/.config/i3/config ~/.config/i3/config
ln -s ~/.dotfiles/.config/gtk-3.0/settings.ini ~/.config/gtk-3.0/settings.ini
ln -s ~/.dotfiles/.config/picom.conf ~/.config/picom.conf
ln -s ~/.dotfiles/.config/polybar/config ~/.config/polybar/config
ln -s ~/.dotfiles/.config/spicetify/Themes/wal ~/.config/spicetify/Themes/wal
ln -s ~/.dotfiles/.config/wal/templates ~/.config/wal/templates
ln -s ~/.dotfiles/.local/share/fonts ~/.local/share/fonts
ln -s ~/.dotfiles/.Xresources ~/.Xresources
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/Wallpapers ~/Pictures/Wallpapers

fc-cache -v

echo "Done."
