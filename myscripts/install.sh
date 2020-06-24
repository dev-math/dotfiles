#!/bin/bash
mkdir -p ~/.myscripts

ln -s ~/.dotfiles/Wallpapers ~/Pictures/Wallpapers
ln -s ~/.dotfiles/i3config ~/.config/i3/config
ln -s ~/.dotfiles/lock.png ~/.config/lock.png
ln -s ~/.dotfiles/myscripts ~/.myscripts
ln -s ~/.dotfiles/picom.conf ~/.config/picom.conf
ln -s ~/.dotfiles/polybar ~/.config/polybar/config
ln -s ~/.dotfiles/rofi/config.rasi ~/.config/rofi/config.rasi
ln -s ~/.dotfiles/rofi/powermen-theme.rasi ~/.config/rofi/powermenu-theme.rasi
ln -s ~/.dotfiles/wal/colors-rofi-powermenu.rasi ~/.config/wal/templates/colors-rofi-powermenu.rasi
ln -s ~/.dotfiles/wal/colors-zathura ~/.config/wal/templates/colors-zathura
ln -s ~/.dotfiles/xinitrc ~/.xinitrc
ln -s ~/.dotfiles/Xresources ~/.Xresources
ln -s ~/.dotfiles/zshrc ~/.zshrc

ln ~/.cache/wal/colors-konsole.colorscheme ~/.local/share/konsole
ln .cache/wal/colors-zathura .config/zathura/zathurarc
