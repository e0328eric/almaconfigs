local rt = require("rust-tools")

rt.setup({
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

vim.keymap.set("n", "K", ":RustHoverAction<CR>")
