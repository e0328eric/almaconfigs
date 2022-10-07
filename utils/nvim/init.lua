-- Almagest's nvim config
-- This config is heavily inspired by https://github.com/anurag3301/my-linux-setup

local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
	execute("packadd packer.nvim")
end

-- include plugins and their config
require("plugins")
require("plug_config.treesitter")
--require("plug_config.base16")
-- require('plug_config.colour')
require("plug_config.toggleTerm")
require("plug_config.presence")
require("plug_config.lualine")
require("plug_config.colorizer")
require("plug_config.lsp_config.lsp-cmp")
require("plug_config.lsp_config.lsp-config")
require("plug_config.lazygit")
require("plug_config.bufferline")
require("plug_config.hop")
require("plug_config.gitsigns")
require("plug_config.dashboard")
require("plug_config.nvim-tree")
require("plug_config.telescope")
require("plug_config.ultisnips")
require("plug_config.kommentary")

require("general")
require("functions")
require("bindings")
require("commands")
require("runner")

vim.cmd([[
" colorscheme
colorscheme bogster

" import filetypes
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
au BufRead,BufNewFile *.asy set filetype=asy
" au BufRead,BufNewFile *.asm set filetype=nasm
" au BufRead,BufNewFile *.glasm set filetype=glasm
filetype plugin indent on

if has('nvim')
  autocmd BufRead Cargo.toml call crates#toggle()
endif
]])
