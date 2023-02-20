local os = require("os")
local math = require("math")
local wezterm = require("wezterm")

local act = wezterm.action
local mux = wezterm.mux

wezterm.on("gui-startup", function()
    local tab, pane, window = mux.spawn_window {}
    window:gui_window():toggle_fullscreen()
end)

local image_table = {
    "/Users/almagest/.config/wezterm/gura.jpg",
    "/Users/almagest/.config/wezterm/Shirakami_Fubuki2.jpg",
    "/Users/almagest/.config/wezterm/mona.jpg",
    "/Users/almagest/.config/wezterm/ame_gura.jpg"
}
local function background_image()
    math.randomseed(os.time())
    return image_table[math.random(4)]
end

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
    colors = {
        tab_bar = {
            -- The color of the strip that goes along the top of the window
            -- (does not apply when fancy tab bar is in use)
            background = '#0b0022',

            -- The active tab is the one that has focus in the window
            active_tab = {
                -- The color of the background area for the tab
                bg_color = '#59c2ff',
                -- The color of the text for the tab
                fg_color = '#16161d',

                -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
                -- label shown for this tab.
                -- The default is "Normal"
                intensity = 'Normal',

                -- Specify whether you want "None", "Single" or "Double" underline for
                -- label shown for this tab.
                -- The default is "None"
                underline = 'None',

                -- Specify whether you want the text to be italic (true) or not (false)
                -- for this tab.  The default is false.
                italic = false,

                -- Specify whether you want the text to be rendered with strikethrough (true)
                -- or not for this tab.  The default is false.
                strikethrough = false
            },

            -- Inactive tabs are the tabs that do not have focus
            inactive_tab = {
                bg_color = '#9a9bb3',
                fg_color = '#16161d'

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `inactive_tab`.
            },

            -- You can configure some alternate styling when the mouse pointer
            -- moves over inactive tabs
            inactive_tab_hover = {
                bg_color = '#98c379',
                fg_color = '#16161d',
                italic = true

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `inactive_tab_hover`.
            },

            -- The new tab button that let you create new tabs
            new_tab = {
                bg_color = '#95e6cb',
                fg_color = '#16161d'

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `new_tab`.
            },

            -- You can configure some alternate styling when the mouse pointer
            -- moves over the new tab button
            new_tab_hover = {
                bg_color = '#98c379',
                fg_color = '#16161d',
                italic = true

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `new_tab_hover`.
            }
        }
    },

    --         ╭──────────────────────────────────────────────────────────╮
    --         │                Window Background Settings                │
    --         ╰──────────────────────────────────────────────────────────╯
    window_background_image = background_image(),
    window_background_image_hsb = {brightness = 0.14},

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
        },
        {
            key = "r",
            mods = "CMD|CTRL",
            action = wezterm.action.ReloadConfiguration
        }
    }
}
