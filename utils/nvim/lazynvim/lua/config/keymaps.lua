-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set(
  "n",
  "<leader><space>",
  ':let @/=""<CR>',
  { noremap = true, silent = true, desc = "Clear search highlights" }
)

vim.keymap.set("n", "<leader>b[", ":bprevious<CR>", { noremap = true, silent = true, desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>b]", ":bnext<CR>", { noremap = true, silent = true, desc = "Next Buffer" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<S-Up>", "<nop>")
vim.keymap.set("i", "<S-Up>", "<nop>")
vim.keymap.set("v", "<S-Up>", "<nop>")
vim.keymap.set("n", "<S-Down>", "<nop>")
vim.keymap.set("i", "<S-Down>", "<nop>")
vim.keymap.set("v", "<S-Down>", "<nop>")

vim.keymap.set("n", "<C-\\>", "O")
vim.keymap.set("i", "<C-\\>", "<C-[>O")
