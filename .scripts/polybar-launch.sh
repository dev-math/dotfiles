#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch main and invisible
echo "---" | tee -a /tmp/invisible.log /tmp/main.log
#polybar invisible >>/tmp/main.log 2>&1 & disown
polybar main >>/tmp/invisible.log 2>&1 & disown

echo "Bars launched..."
