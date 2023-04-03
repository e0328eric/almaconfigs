-- LuaFormatter off
return {
    -- Add the community repository of plugin specifications
    "AstroNvim/astrocommunity",
    -- example of imporing a plugin, comment out to use it or add your own
    -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

    { import = "astrocommunity.colorscheme.nightfox" },
    {
        -- further customize the options set by the community
        "EdenEast/nightfox.nvim",
        opts = {
            options = {
                transparent = true,
            }
        }
    }
    -- { import = "astrocommunity.completion.copilot-lua-cmp" },
}
-- LuaFormatter on
