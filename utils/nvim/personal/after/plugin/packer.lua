local utils = require("almagest.utils")

utils.cfgplugin("packer", function()
    utils.wkmap({
        p = {
            name = "+packer",
            s = {vim.cmd.PackerSync, "Syncing Packer"},
        }
    })
end)
