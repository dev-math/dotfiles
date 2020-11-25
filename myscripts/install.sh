#!/bin/bash
mkdir -p ~/.myscripts
mkdir -p ~/.config/i3
mkdir -p ~/.config/polybar
mkdir -p ~/.config/rofi
mkdir -p ~/.config/wal/templates
mkdir -p ~/.config/zathura
mkdir -p ~/.cache/wal
mkdir -p ~/Pictures/screenshots

echo -n "Delete existing files (y/n)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    echo Yes
	rm ~/.config/i3/config
	rm ~/.config/picom.conf
	rm ~/.confivg/polybar/config
	rm ~/.config/rofi/config.rasi
	rm ~/.config/rofi/powermenu-theme.rasi
	rm ~/.config/wal/templates/colors-rofi-powermenu.rasi
	rm ~/.config/wal/templates/colors-zathura
	rm ~/.config/wal/templates/colors-konsole.colorscheme
	rm ~/.xinitrc
	rm ~/.Xresources
	rm ~/.zshrc

else
	echo "OK, continuing..."
fi

ln -s ~/.dotfiles/Wallpapers ~/Pictures/Wallpapers
ln -s ~/.dotfiles/i3config ~/.config/i3/config
ln -s ~/.dotfiles/lock.png ~/.config/lock.png
ln -s ~/.dotfiles/myscripts/* ~/.myscripts/
ln -s ~/.dotfiles/picom.conf ~/.config/picom.conf
ln -s ~/.dotfiles/polybar ~/.config/polybar/config
ln -s ~/.dotfiles/rofi/config.rasi ~/.config/rofi/config.rasi
ln -s ~/.dotfiles/rofi/powermenu-theme.rasi ~/.config/rofi/powermenu-theme.rasi
ln -s ~/.dotfiles/wal/colors-rofi-powermenu.rasi ~/.config/wal/templates/colors-rofi-powermenu.rasi
ln -s ~/.dotfiles/wal/colors-zathura ~/.config/wal/templates/colors-zathura
ln -s ~/.dotfiles/wal/colors-konsole.colorscheme ~/.config/wal/templates/colors-konsole.colorscheme
ln -s ~/.dotfiles/xinitrc ~/.xinitrc
ln -s ~/.dotfiles/Xresources ~/.Xresources
ln -s ~/.dotfiles/zshrc ~/.zshrc
