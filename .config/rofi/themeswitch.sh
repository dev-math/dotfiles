#!/bin/sh
### Created by ilsenatorov
### Change WALLPAPERDIR to the directory where you store wallpapers

# script edited...
WALLPAPERDIR=~/Pictures/Wallpapers/

if [ -z $@ ]
then
function get_themes()
{
    ls $WALLPAPERDIR
}
echo current; get_themes
else
    THEMES=$@
   if [ x"current" = x"${THEMES}" ]
    then
        exit 0
        #wal -i `cat ~/.cache/wal/wal` > /dev/null
    elif [ -n "${THEMES}" ]
    then
        wal -o ~/.dotfiles/.scripts/afterwal.sh -i "$WALLPAPERDIR${THEMES}" > /dev/null
    fi
fi 
