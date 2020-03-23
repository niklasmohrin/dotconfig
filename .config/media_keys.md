# Steps I took to get media keys working on my Dell Xps 15 7590 (2019)

1. Get `acpid` running
2. Install `light` for brightness control
3. Install `pulseaudio` stuff and pulsemixer for audio control
4. Install `playerctl` for media playback controls across different programs (windows 10 like)
5. Modify /etc/acpi/handler.sh case statement to include the following (before the '*' / default case):

```
video/brightnessup)     light -A 10 ;;
video/brightnessdown)   light -U 10 ;;

button/mute)            runuser -u niklas -- pulsemixer --toggle-mute ;;
button/volumeup)        runuser -u niklas -- pulsemixer --change-volume +5 ;;
button/volumedown)      runuser -u niklas -- pulsemixer --change-volume -5 ;;

cd/next)                runuser -u niklas -- playerctl next ;;
cd/prev)                runuser -u niklas -- playerctl previous ;;
cd/play)                runuser -u niklas -- playerctl play-pause ;;
```

I am using `runuser` here, because `pulsemixer` and `playerctl` did not work (the `acpi` process is run by root, I tried this and it worked, so I kept it like that).

I found these case names by pressing the buttons on my keyboard and checking `systemctl status acpid`. You can see the logs there.
