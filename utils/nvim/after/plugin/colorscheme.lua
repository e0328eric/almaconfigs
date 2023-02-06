--  ╭──────────────────────────────────────────────────────────────────────────────╮
--  │                           Using Base16 Colorscheme                           │
--  ╰──────────────────────────────────────────────────────────────────────────────╯

local colorscheme = require("base16-colorscheme")

vim.cmd("colorscheme base16-ocean")

colorscheme.setup({
	base00 = "#16161D",
	base01 = "#2c313c",
	base02 = "#3e4451",
	base03 = "#6c7891",
	base04 = "#565c64",
	base05 = "#abb2bf",
	base06 = "#9a9bb3",
	base07 = "#c5c8e6",
	base08 = "#e06c75",
	base09 = "#d19a66",
	base0A = "#e5c07b",
	base0B = "#98c379",
	base0C = "#95e6cb",
	base0D = "#59c2ff",
	base0E = "#c678dd",
	base0F = "#a06949",
})

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
