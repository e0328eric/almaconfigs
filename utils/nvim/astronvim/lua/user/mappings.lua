return {
    n = {
        --  -- Buffer
        ["<leader>b"] = {name = " Buffers"},
        ["<leader>bn"] = {"<cmd>tabnew<cr>", desc = "New tab"},
        ["<leader>bd"] = {"<cmd>bdelete<cr>", desc = "Delete Buffer"},
        ["<leader>bD"] = {
            function()
                require("astronvim.utils.status").heirline.buffer_picker(
                    function(bufnr)
                        require("astronvim.utils.buffer").close(bufnr)
                    end)
            end,
            desc = "Delete buffer from tabline"
        },
        ["<leader><space>"] = {
            function() vim.cmd([[let @/=""]]) end,
            desc = "Remove Selected Highlight"
        },
        ["<Tab>"] = {"<cmd>bnext<cr>", desc = "Switch into a next buffer"},
        ["<S-Tab>"] = {
            "<cmd>bprevious<cr>",
            desc = "Switch into a previous buffer"
        }
    },
    t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
    }
}
