local utils = require("almagest.utils")

utils.cfgplugin("rust-tools", {
    server = {
        cmd = {"rust-analyzer"},
        filetypes = {"rust"},
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    allFeatures = true,
                    overrideCommand = {
                        "cargo", "clippy", "--workspace",
                        "--message-format=json", "--all-targets",
                        "--all-features"
                    }
                }
            }
        }
    }
})
