#!/bin/bash

rm $HOME/.Xresources
cp $HOME/.cache/wal/.Xresources $HOME
xrdb -merge ~/.Xresources

rm $HOME/.dotfiles/.scripts/lock
cp $HOME/.cache/wal/lock-alpha.sh $HOME/.dotfiles/.scripts/lock
chmod +x $HOME/.dotfiles/.scripts/lock 

spicetify update

pywal-discord
rm $HOME/.config/zathura/zathurarc
cp $HOME/.cache/wal/zathurarc $HOME/.config/zathura/zathurarc

/opt/oomox/plugins/icons_papirus/change_color.sh /opt/oomox/scripted_colors/xresources/xresources-reverse
oomox-cli /opt/oomox/scripted_colors/xresources/xresources-reverse

echo 'awesome.restart()' | awesome-client &> /dev/null
