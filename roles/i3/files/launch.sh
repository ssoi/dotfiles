#!/usr/bin/env bash


# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

MONITOR=`xrandr --query | grep " connected" | cut -d" " -f1 | cut -d":" -f2`

# Launch Polybar, using default config location ~/.config/polybar/config
MONITOR=$MONITOR polybar mainbar-i3 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar launched..."
