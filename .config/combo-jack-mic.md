# Fix microphone detection of the combo audio jack
## Dell XPS 15 7590

For me, the solution in the [Dell XPS 15 Arch Wiki page](https://wiki.archlinux.org/index.php/Dell_XPS_15) did not work.

What fixed it for me, was the option found in the [Advanced Linux Sound Architecture Troubleshooting section](https://wiki.archlinux.org/index.php/Dell_XPS_15):

```options snd_hda_intel index=0 model=dell-headset-multi```

The model setting may not be the same for every model, I found out my audio codec with `alsa-info.sh` from the `alsa-utils` package. The matching setting can be found [here](https://www.kernel.org/doc/html/latest/sound/hd-audio/models.html).

Tested on Linux kernel 5.5.19-1-MANJARO.
