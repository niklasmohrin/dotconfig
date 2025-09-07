#!/bin/sh

systemctl --user import-environment WAYLAND_DISPLAY
systemctl --user start qtile-session.target

# autorandr --change &
# libinput-gestures &

# libinput-gestures-setup start &

# suspend-then-hibernate after 10 minutes (see /etc/systemd/logind.conf)

# light -O
# xidlehook \
#     --not-when-fullscreen --not-when-audio \
#     --socket '/tmp/xidlehook.sock' \
#     --timer 600 'light -O; light -S 5' 'light -I' \
#     --timer 10 'light -I; i3lock --color 000000' '' \
#     --timer 1200 'systemctl suspend-then-hibernate' '' \
#     &
