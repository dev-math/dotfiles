#!/bin/bash

echo -n "This process will overwrite existing files. Continue (y/n)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    # remove files
    rm -Rf ~/.config/i3
    rm -Rf ~/.config/polybar
    rm -Rf ~/.config/wal/templates
    rm -Rf ~/.Xresources
    rm -Rf ~/Pictures/wallpapers
    rm -Rf ~/.config/picom.conf
    #rm -Rf ~/.config/dunst
    rm -Rf ~/.config/zathura

    # create folders
    mkdir -p ~/.local/share/fonts
    mkdir -p ~/.local/bin
    mkdir -p ~/.config/wal
    mkdir -p ~/Pictures/screenshots
    #mkdir -p ~/.config/dunst
    mkdir -p ~/.config/zathura
    sudo mkdir -p /etc/sddm.conf.d

    # Install config files
    ln -sf ~/.dotfiles/config/i3 ~/.config/
    ln -sf ~/.dotfiles/config/polybar ~/.config/
    ln -sf ~/.dotfiles/config/wal/templates ~/.config/wal/
    ln -sf ~/.dotfiles/bin/* ~/.local/bin/
    ln -sf ~/.dotfiles/config/picom.conf ~/.config/
    ln -sf ~/.dotfiles/config/picom.conf ~/.config/
    sudo ln -sf ~/.dotfiles/config/sddm_user_settings.conf /etc/sddm.conf.d/
    

    # Install fonts
    cp -r ~/.dotfiles/misc/fonts/* ~/.local/share/fonts/
    fc-cache -v
    
    # Wallpapers
    ln -sf ~/.dotfiles/misc/wallpapers ~/Pictures/wallpapers

    # SDDM Theme

    # SETUP LIGHTDM
    # pkgs: lightdm lightdm-webkit2-greeter lightdm-webkit2-theme-glorious
    # Set default lightdm greeter to lightdm-webkit2-greeter
    #sudo sed -i 's/^\(#?greeter\)-session\s*=\s*\(.*\)/greeter-session = lightdm-webkit2-greeter #\1/ #\2g' /etc/lightdm/lightdm.conf
    # Set default lightdm-webkit2-greeter theme to Glorious
    #sudo sed -i 's/^webkit_theme\s*=\s*\(.*\)/webkit_theme = glorious #\1/g' /etc/lightdm/lightdm-webkit2-greeter.conf
    # sudo sed -i 's/^debug_mode\s*=\s*\(.*\)/debug_mode = true #\1/g' /etc/lightdm/lightdm-webkit2-greeter.conf
    #systemctl enable lightdm

    # Services
    #systemctl enable NetworkManager.service
    #systemctl enable sddm.service

    # symlink pywal files
    wal -i ~/Pictures/wallpapers
    ln -sf ~/.cache/wal/.Xresources ~/
    #ln -sf ~/.cache/wal/dunstrc ~/.config/dunst/
    ln -sf ~/.cache/wal/zathurarc ~/.config/zathura/

    echo "Done."
else
	exit
fi