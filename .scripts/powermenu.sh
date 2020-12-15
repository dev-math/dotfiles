#!/bin/bash

rofi_command="rofi -theme ~/.cache/wal/colors-rofi-powermenu"

### Options ###
power_off=""
reboot=""
lock=""
suspend=""
log_out=""
hibernate=""
# Variable passed to rofi
options="$power_off\n$reboot\n$lock\n$hibernate\n$suspend\n$log_out"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 2)"
case $chosen in
    $hibernate)
        # turn off the computer but apps stay open. When resuming, the saved state is restored
        ~/.dotfiles/.scripts/lock && systemctl hibernate
        ;;
    $power_off)
	systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $lock)
        ~/.scripts/lock.sh
        ;;
    $suspend)
        # puts the computer on a low power consuption mode
        ~/.dotfiles/.scripts/lock && systemctl suspend
        ;;
    $log_out)
        # i3-msg exit
        echo 'awesome.quit()' | awesome-client
        ;;
esac
