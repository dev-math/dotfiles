#!/bin/bash
. $HOME/.cache/wal/colors.sh

rm $HOME/.Xresources
cp $HOME/.cache/wal/.Xresources $HOME
xrdb -merge ~/.Xresources
feh --bg-fill "$wallpaper"

echo 'awesome.restart()' | awesome-client &> /dev/null

FILE=$HOME/.local/bin/lock
if [[ ! -e "$FILE" ]]; then
    chmod +x $HOME/.cache/wal/lock-alpha.sh
    chmod +x $HOME/.cache/wal/lockwal-bar.sh
    chmod +x $HOME/.cache/wal/lockwal.sh
else
    rm $HOME/.local/bin/lock
    ln -s $HOME/.cache/wal/lock-alpha.sh $HOME/.local/bin/lock
fi

spicetify update

pywal-discord

rm $HOME/.config/zathura/zathurarc
cp $HOME/.cache/wal/zathurarc $HOME/.config/zathura/zathurarc

/opt/oomox/plugins/icons_papirus/change_color.sh /opt/oomox/scripted_colors/xresources/xresources-reverse
oomox-cli /opt/oomox/scripted_colors/xresources/xresources-reverse
