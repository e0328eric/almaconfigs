from libqtile import bar
from .widgets import *
from libqtile.config import Screen
from modules.keys import terminal
import os

separator = widget.TextBox(text = '|', padding = 0, fontsize = 28)

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Sep(padding=3, linewidth=0, background="#2f343f"),
                widget.Image(filename='~/.config/qtile/eos-c.png', margin=3, background="#2f343f", mouse_callbacks={'Button1': lambda: qtile.cmd_spawn("rofi -show combi")}),
                widget.Sep(padding=4, linewidth=0, background="#2f343f"), 
                widget.GroupBox(
                    highlight_method='line',
                    this_screen_border="#5294e2",
                    this_current_screen_border="#5294e2",
                    active="#ffffff",
                    inactive="#848e96",
                    background="#2f343f",
                ),
                separator,
                widget.Prompt(),
                widget.Spacer(length=5),
                widget.WindowName(foreground='#99c0de',fmt='{}'),
                widget.Chord(
                    chords_colors={
                        'launch': ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.CurrentLayoutIcon(scale=0.75),
                widget.Systray(icon_size = 20),
                separator,
                volume,
                separator,
                widget.BatteryIcon(),
                separator,
                widget.Wlan(
                    interface="wlan0",
                ),
                separator,
                widget.Bluetooth(
                    foreground='#ffffff'
                ),
                separator,
                widget.CPU(),
                separator,
                widget.Clock(
                    format=' %Y-%m-%d %a %I:%M %p',
                    foreground='#9bd689',
                ),
                separator,
                widget.TextBox(
                    text='',
                    mouse_callbacks= {
                        'Button1':
                        lambda: qtile.cmd_spawn(os.path.expanduser('~/.config/rofi/powermenu.sh'))
                    },
                    foreground='#e39378',
                )
            ],
            30,  # height in px
            background="#404552"  # background color
        ), ),
]
