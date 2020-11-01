# Fix microphone detection of the combo audio jack on the Dell XPS 15 7590

## First version

For me, the solution in the
[Dell XPS 15 Arch Wiki page](https://wiki.archlinux.org/index.php/Dell_XPS_15)
did not work right away, as I needed to also specify the `index`:

```
options snd_hda_intel index=0 model=dell-headset-multi
```

The model setting may not be the same for every model,
I found out my audio codec with `alsa-info.sh` from the `alsa-utils` package.
The matching setting can be found
[here](https://www.kernel.org/doc/html/latest/sound/hd-audio/models.html).

Tested on Linux kernel `5.5.19-1-MANJARO`.

## Update as of July 2020

This stopped working at some point. I cannot really determine what broke
the setting again, but I am currently on the kernel `5.6.16-1-MANJARO`.

However, I got it to work again, using `pavucontrol-qt`.
In there, I could select my headphone microphone under the `Input Devices`
tab. The one I was looking for was conveniently called `microphone`.

When playing around with this, I noticed that my headphone sound stops
working once I got the microphone to work.
This can be "fixed" by stopping all input / output and replugging the
headphones (and selecting the correct devices again).
