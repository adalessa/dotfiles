#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# polybar -c ~/.config/polybar/config.ini --reload main &

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar -c ~/.config/polybar/config.ini --reload main &
  done
else
  polybar -c ~/.config/polybar/config.ini --reload main &
fi

echo "Polybar launched..."
