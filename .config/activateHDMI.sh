#!/bin/sh

direction="left"

if [ "$#" -ne "0" ]; then
    direction="$1"
fi

eval "xrandr --output eDP-1 --primary --auto --output DP-3 --auto --$direction-of eDP-1"
