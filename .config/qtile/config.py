# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Imports

import os
import subprocess

from libqtile.config import Key, Screen, Group, Drag, Click, Match
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook

from typing import List  # noqa: F401

# Global constants

mod = "mod4"  # Super / Windows Key
net_interface = "enp0s3"
terminal_emulator = "alacritty"
file_manager = "nemo"
application_runner = "rofi -show run"
web_browser = "firefox-developer-edition"
email_program = "thunderbird"
# lock_command = "xscreensaver-command -lock"
lock_command = "systemctl suspend-then-hibernate"

# Keys

keys = [
    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.down()),
    Key([mod], "j", lazy.layout.up()),

    # Move windows up or down in current stack
    Key([mod, "control"], "k", lazy.layout.shuffle_down()),
    Key([mod, "control"], "j", lazy.layout.shuffle_up()),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next()),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
    Key([mod], "Return", lazy.spawn(terminal_emulator)),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "w", lazy.window.kill()),
    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod], "r", lazy.spawn(application_runner)),
    Key([mod], "e", lazy.spawn(file_manager)),
    Key([mod], "b", lazy.spawn(web_browser)),
    Key([mod], "m", lazy.spawn(email_program)),
    Key([mod], "l", lazy.spawn(lock_command)),
]

# Mouse events
mouse = [
    Drag([mod],
         "Button1",
         lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod],
         "Button3",
         lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

# Groups

groups = [
    Group("Side"),
    Group("Code", layout="max"),
    Group("Web"),
    Group("Media", matches=[Match(wm_class=["spotify", "Spotify"])]),
    Group("Com", matches=[
        Match(wm_class=["discord"]),
    ]),
]

group_labels = [g.name for g in groups]

# Groups keybindings
for i, label in enumerate(group_labels, 1):
    keys.append(Key([mod], str(i), lazy.group[label].toscreen()))
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(label)))

# Layouts

layout_theme = {
    "border_width": 2,
    "border_focus": "773388",
    "border_normal": "1D1F21",
    "margin": 8,
}

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    layout.Matrix(columns=3, **layout_theme),
    layout.MonadWide(**layout_theme),
    layout.Stack(**layout_theme),
]

# Widgets

widget_defaults = dict(
    font='Cascadia Code Bold',
    fontsize=13,
    padding=3,
)
extension_defaults = widget_defaults.copy()


def sep():
    return widget.TextBox("|", foreground="#aaaaaa")


screens = [
    Screen(top=bar.Bar(
        [
            widget.GroupBox(disable_drag=True,
                            highlight_method="line",
                            highlight_color=["000000", "553388"]),
            sep(),
            widget.WindowName(),
            sep(),
            widget.Clock(format='%H:%M | %d. %b %y | %A'),
            sep(),
            widget.Net(format="{down} ↓↑ {up}"),
            sep(),
            widget.Systray(),
            sep(),
            widget.Backlight(format="☀{percent: 2.0%}",
                             backlight_name="intel_backlight"),
            sep(),
            widget.Mpris2(objname="org.mpris.MediaPlayer2.spotify",
                          display_metadata=["xesam:title", "xesam:artist"],
                          scroll_wait_intervals=10000,
                          scroll_chars=50,
                          stop_pause_text="Paused"),
            sep(),
            widget.BatteryIcon(),
            widget.Battery(format="{percent:2.0%}"),
            sep(),
            widget.CurrentLayout(),
        ],
        opacity=0.8,
        size=28,
    )),
    Screen(top=bar.Bar([
        widget.GroupBox(disable_drag=True,
                        highlight_method="line",
                        highlight_color=["000000", "553388"]),
        sep(),
        widget.WindowName(),
        sep(),
        widget.Clock(format='%H:%M | %d. %b %y | %A'),
        sep(),
        widget.Mpris2(objname="org.mpris.MediaPlayer2.spotify",
                      display_metadata=["xesam:title", "xesam:artist"],
                      scroll_wait_intervals=10000,
                      scroll_chars=50,
                      stop_pause_text="Paused"),
        sep(),
        widget.CurrentLayout(),
    ],
                       opacity=0.8,
                       size=28)),
]

# Configuration constants
# http://docs.qtile.org/en/latest/manual/config/index.html#configuration-variables

floating_layout = layout.Floating(float_rules=[
    {
        'wmclass': 'confirm'
    },
    {
        'wmclass': 'dialog'
    },
    {
        'wmclass': 'download'
    },
    {
        'wmclass': 'error'
    },
    {
        'wmclass': 'file_progress'
    },
    {
        'wmclass': 'notification'
    },
    {
        'wmclass': 'splash'
    },
    {
        'wmclass': 'toolbar'
    },
    {
        'wmclass': 'confirmreset'
    },  # gitk
    {
        'wmclass': 'makebranch'
    },  # gitk
    {
        'wmclass': 'maketag'
    },  # gitk
    {
        'wname': 'branchdialog'
    },  # gitk
    {
        'wname': 'pinentry'
    },  # GPG key password entry
    {
        'wmclass': 'ssh-askpass'
    },  # ssh-askpass
])

wmname = "LG3D"

# Autostart script


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser("~")
    subprocess.call([home + "/.config/qtile/autostart.sh"])
