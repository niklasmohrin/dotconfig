import os
import re
import subprocess

from libqtile import bar, hook, layout, widget
from libqtile.command import lazy
from libqtile.config import Click, Drag, Group, Key, Match, Screen

mod = "mod4"  # Super / Windows Key
net_interface = "enp0s3"
terminal_emulator = "alacritty"
file_manager = "nemo"
application_runner = "rofi -show run"
web_browser = "firefox"
email_program = "thunderbird"
lock_command = "i3lock --color 000000"
# lock_command = "\
#         xidlehook-client --socket /tmp/xidlehook.sock \
#         control --action trigger --timer 1"

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
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "q", lazy.window.kill()),
    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod], "r", lazy.spawn(application_runner)),
    Key([mod], "e", lazy.spawn(file_manager)),
    Key([mod], "b", lazy.spawn(web_browser)),
    Key([mod], "m", lazy.spawn(email_program)),
    Key([mod, "shift"], "l", lazy.spawn(lock_command)),

    Key([], "XF86AudioLowerVolume", lazy.spawn("wpctl set-volume @DEFAULT_SINK@ 5%-")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("wpctl set-volume @DEFAULT_SINK@ 5%+")),
    Key([], "XF86AudioMute", lazy.spawn("wpctl set-mute @DEFAULT_SINK@ toggle")),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
]

mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.toggle_floating()),
    # Click([mod], "Button2", lazy.window.bring_to_front()),
]

groups = [
    Group("Side"),
    Group("Code", layout="max"),
    Group("Web"),
    Group("Media", matches=[Match(wm_class=["spotify", "Spotify"])]),
    Group(
        "Com",
        matches=[
            Match(wm_class=["discord"]),
        ],
    ),
]
group_labels = [g.name for g in groups]

for i, label in enumerate(group_labels, 1):
    keys.append(Key([mod], str(i), lazy.group[label].toscreen(toggle=True)))
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(label)))

layout_theme = {
    "border_width": 2,
    "border_focus": "773388",
    "border_normal": "1D1F21",
    # "margin": 8,
}

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Max(),
    # layout.Matrix(columns=3, **layout_theme),
    # layout.MonadWide(**layout_theme),
    # layout.Stack(**layout_theme),
]

widget_defaults = dict(
    font="Ubuntu Nerd Font Med",
    fontsize=14,
    padding=3,
)
extension_defaults = widget_defaults.copy()


def sep():
    return widget.TextBox("|", foreground="#aaaaaa")


def my_screen(primary):
    return Screen(
        wallpaper="~/Pictures/qtile_wallpaper",
        wallpaper_mode="fill",
        bottom=bar.Bar(
            [
                widget.GroupBox(
                    disable_drag=True,
                    highlight_method="line",
                    highlight_color=["000000", "553388"],
                ),
                sep(),
                widget.TaskList(),
                sep(),
                widget.Clock(format="%H:%M | %d. %b %y | %A"),
                sep(),
                widget.Net(format="{down} ↓↑ {up}"),
                sep(),
                *([widget.Systray(), sep()] if primary else []),
                widget.Backlight(
                    format="☀{percent: 2.0%}", backlight_name="intel_backlight"
                ),
                sep(),
                widget.Mpris2(
                    objname="org.mpris.MediaPlayer2.spotify",
                    display_metadata=["xesam:title", "xesam:artist"],
                    scroll_wait_intervals=10000,
                    scroll_chars=50,
                    stop_pause_text="Paused",
                ),
                sep(),
                widget.BatteryIcon(),
                widget.Battery(format="{percent:2.0%}"),
                sep(),
                widget.CurrentLayout(),
            ],
            size=28,
        ),
    )


screens = [
    my_screen(primary=True),
    my_screen(primary=False),
    my_screen(primary=False),
]

# Configuration constants
# http://docs.qtile.org/en/latest/manual/config/index.html#configuration-variables

floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirm"),
        Match(wm_class="dialog"),
        Match(wm_class="download"),
        Match(wm_class="error"),
        Match(wm_class="file_progress"),
        Match(wm_class="notification"),
        Match(wm_class="splash"),
        Match(wm_class="toolbar"),
        Match(title=re.compile(r"^Password Required - Mozilla Firefox$")),
    ]
)

wmname = "LG3D"


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser("~")
    subprocess.call([home + "/.config/qtile/autostart.sh"])
