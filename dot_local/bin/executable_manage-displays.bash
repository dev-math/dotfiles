#!/usr/bin/env bash

laptop_screen='eDP1'

# Start listening for ACPI events
acpi_listen |
while IFS= read -r event; do
    if [[ "$event" =~ "button/lid" ]]; then
        state=($event) && state="${state[-1]}"

        if [[ "$state" == "open" ]]; then
            # turn on laptop_screen if its off
            xrandr --output "$laptop_screen" --auto 
        elif [[ "$state" == "closed" ]]; then
            # if only one display is connected then suspend the pc
            if [ $(xrandr | grep -i " connected" | wc -l) == 1 ]; then
                # We leave a bit of time for locking to happen before putting 
                # the system to sleep
                ~/.local/bin/lockscreen && sleep 3
                if ! grep -q open /proc/acpi/button/lid/LID/state; then
                    systemctl suspend
                fi
            else
                # let autorandr figure out the correct display config
                autorandr --change
            fi
        fi
    fi
done
