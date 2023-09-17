#!/bin/sh

picom &
# nitrogen --restore &
dunst &
libinput-gestures-setup start &

nm-applet &
pasystray &
blueman-applet &
optimus-manager-qt &

# suspend-then-hibernate after 10 minutes (see /etc/systemd/logind.conf)
# xscreensaver -no-splash &
# xset s 30  # xscreensaver overwrites this anyway?
# xss-lock -l -- xscreensaver-command -lock &
# xset s 300
# light-locker --idle-hint --late-locking &

light -O
xidlehook \
    --not-when-fullscreen --not-when-audio \
    --socket '/tmp/xidlehook.sock' \
    --timer 600 'light -O; light -S 5' 'light -I' \
    --timer 10 'light -I; i3lock --color 000000' '' \
    --timer 1200 'systemctl suspend-then-hibernate' '' \
    &
