from libqtile.command import lazy
from libqtile.config import EzKey as Key

modifier_keys = {
   'M': 'mod4',
   'A': 'mod1',
   'S': 'shift',
   'C': 'control',
}
mod = "mod4"
terminal = "alacritty"
browser = "firefox"

keys = [
    # Switch between windows
    Key("M-<Left>", lazy.layout.left(), desc="Move focus to left"),
    Key("M-<Right>", lazy.layout.right(), desc="Move focus to right"),
    Key("M-<Up>", lazy.layout.up(), desc="Move focus up"),
    Key("M-<Down>", lazy.layout.down(), desc="Move focus down"),
    Key("M-<space>", lazy.layout.next(), desc="Move window focus to other window"),

    Key("M-r", lazy.spawn("rofi -show combi"), desc="spawn rofi"),
    Key("M-C-s", lazy.spawn("rofi -show file-browser-extended"), desc="spawn rofi filebrowser"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key("M-S-<Left>", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key("M-S-<Right>", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key("M-S-<Up>", lazy.layout.shuffle_up(), desc="Move window up"),
    Key("M-S-<Down>", lazy.layout.shuffle_down(), desc="Move window down"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key("M-C-<Left>", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key("M-C-<Right>", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key("M-C-<Up>", lazy.layout.grow_up(), desc="Grow window up"),
    Key("M-C-<Down>", lazy.layout.grow_down(), desc="Grow window down"),
    Key("M-n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key("M-f", lazy.window.toggle_floating(), desc="Toggle/Detoogle floating"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    # Key([mod, "shift"],
        # "Return",
        # lazy.layout.toggle_split(),
        # desc="Toggle between split and unsplit sides of stack"),
    Key("M-S-<Return>", lazy.spawn(browser), desc="Launch browser"),
    Key("M-<Return>", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key("M-<Tab>", lazy.next_layout(), desc="Toggle between layouts"),
    Key("M-S-q", lazy.window.kill(), desc="Kill focused window"),
    Key("M-S-C-a", lazy.layout.swap_column_left()),
    Key("M-S-C-s", lazy.layout.swap_column_right()),
    Key("M-S-<space>", lazy.layout.flip()),
    Key("M-S-c", lazy.restart(), desc="Restart Qtile"),
    Key("M-S-x", lazy.shutdown(), desc="Shutdown Qtile"),
    Key("M-S-r", lazy.reload_config(), desc="Reload config files"),
    Key("<XF86AudioRaiseVolume>", lazy.spawn("amixer set Master 3%+")),
    Key("<XF86AudioLowerVolume>", lazy.spawn("amixer set Master 3%-")),
    Key("<XF86AudioMute>", lazy.spawn("amixer set Master toggle")),
    Key("<XF86MonBrightnessDown>", lazy.spawn("xrandr --output eDP-1 --brightness 0.3")),
    Key("<XF86MonBrightnessUp>", lazy.spawn("xrandr --output eDP-1 --brightness 0.6")),
    Key("<XF86KbdBrightnessDown>", lazy.spawn("brightnessctl --device'apple::kbd_backlight' set 40")),
    Key("<XF86KbdBrightnessUp>", lazy.spawn("brightnessctl --device'apple::kbd_backlight' set 0")),
]
