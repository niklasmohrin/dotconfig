#!/bin/sh

picom &
nitrogen --restore &
nm-applet &
xscreensaver -no-splash &
xss-lock -- xscreensaver-command -lock &
pasystray &
libinput-gestures-setup start
blueman-applet &
