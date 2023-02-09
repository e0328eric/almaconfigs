local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

wezterm.on("gui-startup", function()
    local tab, pane, window = mux.spawn_window {}
    window:gui_window():toggle_fullscreen()
end)

return {
    --         ╭──────────────────────────────────────────────────────────╮
    --         │                      Font Settings                       │
    --         ╰──────────────────────────────────────────────────────────╯
    font = wezterm.font_with_fallback({
        "Comic Code Ligatures", "FiraCode Nerd Font", "JetbrainMono Nerd Font",
        "Noto Sans Egyptian Hieroglyphs"
    }),
    font_size = 13.0,
    unicode_version = 15,

    --         ╭──────────────────────────────────────────────────────────╮
    --         │                       Colorscheme                        │
    --         ╰──────────────────────────────────────────────────────────╯
    color_scheme = "AyuDark (Gogh)",

    --         ╭──────────────────────────────────────────────────────────╮
    --         │                Window Background Settings                │
    --         ╰──────────────────────────────────────────────────────────╯
    window_background_image = "/Users/almagest/.config/wezterm/mona.jpg",
    window_background_image_hsb = {brightness = 0.2},

    --  ╭──────────────────────────────────────────────────────────╮
    --  │                           etc                            │
    --  ╰──────────────────────────────────────────────────────────╯
    native_macos_fullscreen_mode = true,

    --         ╭──────────────────────────────────────────────────────────╮
    --         │                       Keybindings                        │
    --         ╰──────────────────────────────────────────────────────────╯
    keys = {
        {key = "w", mods = "CMD|CTRL", action = act.SpawnWindow}, {
            key = "v",
            mods = "CTRL|SHIFT",
            action = act.SplitHorizontal({domain = "CurrentPaneDomain"})
        }, {
            key = "s",
            mods = "CTRL|SHIFT",
            action = act.SplitVertical({domain = "CurrentPaneDomain"})
        },
        {key = "f", mods = "CMD|CTRL", action = wezterm.action.ToggleFullScreen},
        {
            key = "Enter",
            mods = "ALT",
            action = wezterm.action.DisableDefaultAssignment
        }
    }
}
