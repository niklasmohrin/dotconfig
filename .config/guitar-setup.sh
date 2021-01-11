#!/bin/sh

pactl unload-module module-null-sink
pactl unload-module module-loopback
pactl unload-module module-loopback
pactl load-module module-null-sink sink_name=collected
pactl load-module module-loopback sink=collected
pactl load-module module-loopback sink=collected

# Leveling for devices:
#   Loopback KATANA: 146%
#   Loopback HyperX: 78%
#   Null Output: 140%
#   HyperX Input: 120%
#   Monitor Nulloutput: 150%
#   Katana Input: 120%
# Set input of recording stream to "Monitor of Null Sink"

# See
# - https://askubuntu.com/questions/868817/collecting-and-mixing-sound-input-from-different-microphones
# - https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Modules/#module-loopback
# - https://askubuntu.com/questions/171287/how-to-pass-record-audio-output-as-an-input-device
