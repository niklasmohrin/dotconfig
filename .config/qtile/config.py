import os
import re
import subprocess

from libqtile import bar, hook, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

mod = "mod4"  # Super / Windows Key
terminal_emulator = "alacritty"
file_manager = "nemo"
application_runner = "rofi -show combi"
web_browser = "firefox"
email_program = "thunderbird"
lock_command = "i3lock --color 000000"

keys = [
    Key([mod], "k", lazy.layout.down()),
    Key([mod], "j", lazy.layout.up()),
    Key([mod, "control"], "k", lazy.layout.shuffle_down()),
    Key([mod, "control"], "j", lazy.layout.shuffle_up()),
    Key([mod, "control"], "Left", lazy.layout.shrink_main()),
    Key([mod, "control"], "Right", lazy.layout.grow_main()),

    Key([mod], "space", lazy.layout.next()),
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod, "shift"], "l", lazy.spawn(lock_command)),
    Key([mod], "q", lazy.window.kill()),
    Key([mod], "Return", lazy.spawn(terminal_emulator)),
    Key([mod], "r", lazy.spawn(application_runner)),
    Key([mod], "e", lazy.spawn(file_manager)),
    Key([mod], "b", lazy.spawn(web_browser)),
    Key([mod], "m", lazy.spawn(email_program)),
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
]

groups = [
    Group("Side"),
    Group("Code", layout="max"),
    Group("Web"),
    Group("Media", matches=[Match(wm_class=re.compile("spotify|Spotify"))]),
    Group("Com", matches=[Match(wm_class="discord")]),
]

for i, group in enumerate(groups, 1):
    keys.append(Key([mod], str(i), lazy.group[group.name].toscreen(toggle=True)))
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(group.name)))

accent_color = "117fb2"

layout_theme = {
    "border_width": 1,
    "border_focus": accent_color,
    "border_normal": "1D1F21",
}

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Max(),
    # layout.Matrix(columns=3, **layout_theme),
    layout.MonadWide(**layout_theme),
    # layout.Stack(**layout_theme),
]

widget_defaults = dict(
    font="Ubuntu Nerd Font Med",
    fontsize=14,
    padding=3,
)
extension_defaults = widget_defaults.copy()


def sep():
    return widget.Sep(padding=4)


def my_screen(primary):
    return Screen(
        wallpaper="~/Pictures/qtile_wallpaper",
        wallpaper_mode="fill",
        top=bar.Bar(
            [
                widget.GroupBox(disable_drag=True, highlight_method="block"),
                sep(),
                widget.TaskList(
                    border=accent_color, borderwidth=1, max_title_width=200
                ),
                widget.Clock(format="%a, %d %b %y, %H:%M"),
                widget.Spacer(length=bar.STRETCH),
                sep(),
                widget.WidgetBox(
                    close_button_location="right",
                    widgets=[
                        widget.CPU(),
                        widget.Sep(),
                        widget.Net(),
                        widget.Sep(),
                        widget.CurrentLayout(),
                        widget.Sep(),
                    ],
                ),
                sep(),
                *([widget.Systray(), sep()] if primary else []),
                widget.Backlight(
                    format="☀{percent: 2.0%}", backlight_name="amdgpu_bl1"
                ),
                sep(),
                widget.BatteryIcon(scale=1.2),
                widget.Battery(format="{percent:2.0%}"),
                widget.Spacer(length=5),
            ],
            size=28,
        ),
    )


screens = [
    my_screen(primary=True),
    my_screen(primary=False),
    my_screen(primary=False),
]

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
        Match(title="Password Required - Mozilla Firefox"),
    ]
)


# @hook.subscribe.startup_once
# def start_once():
#     home = os.path.expanduser("~")
#     subprocess.call([home + "/.config/qtile/autostart.sh"])

from libqtile.backend.wayland import InputConfig

wl_input_rules = {
    "type: keyboard": InputConfig(kb_layout="us"),

}
