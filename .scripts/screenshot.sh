NAME=~/Pictures/screenshots/$(date '+%d-%m-%Y-%T').png
if maim -s $NAME; then
    xclip -selection clipboard -t image/png -filter $NAME
    notify-send "Screenshot saved at $NAME" --icon=camera-photo
fi
