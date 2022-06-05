local fn = vim.fn
local g = vim.g
local cmd = vim.cmd
local opt = vim.opt

g.mapleader = " "
g.maplocalleader = " "

-- bootstrap 'packer' package for neovim
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

require("packer").startup(function(use)
	-- Packer Package
	use("wbthomason/packer.nvim")

	-- Theme Relateed Packages
	use("vim-airline/vim-airline")
	use("vim-airline/vim-airline-themes")
	use("chriskempson/base16-vim")

	-- Languages
	use("mhartington/formatter.nvim")
	use({ "fatih/vim-go", run = ":GoUpdateBinaries" })
	use("ziglang/zig.vim")
	use("rust-lang/rust.vim")
	use("mhinz/vim-crates")
	use("dense-analysis/ale")

	-- ultisnips
	use("SirVer/ultisnips")

	-- which-keys
	use("folke/which-key.nvim")

	-- telescope
	use({ "nvim-telescope/telescope.nvim", requires = "nvim-lua/plenary.nvim" })
	use("nvim-telescope/telescope-file-browser.nvim")

	-- Miscellaneous
	use({ "mg979/vim-visual-multi", branch = "master" })
	use("antoyo/vim-licenses")
	use("ggandor/lightspeed.nvim")
	use("terrortylor/nvim-comment")
	use("voldikss/vim-floaterm")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)

--------------------------------------------------
--  Basic Setting
--------------------------------------------------
cmd("syntax enable")
cmd("set autoindent")
cmd("set background=dark")
cmd("set clipboard=unnamedplus")
cmd("set cmdheight=2")
cmd("set conceallevel=0")
cmd("set cursorline")
cmd("set encoding=utf-8")
cmd("set expandtab")
cmd("set fileencoding=utf-8")
cmd("set formatoptions-=cro")
cmd("set guifont=Fira\\ Code\\ Nerd\\ Font")
cmd("set hidden")
cmd("set incsearch")
cmd("set iskeyword+=-")
cmd("set laststatus=2")
cmd("set mouse=n")
cmd("set nobackup")
cmd("set noshowmode")
cmd("set nowrap")
cmd("set nowritebackup")
cmd("set nu rnu")
cmd("set pumheight=10")
cmd("set ruler")
cmd("set scrolloff=3")
cmd("set shiftwidth=4")
cmd("set shortmess+=c")
cmd("set showtabline=2")
cmd("set signcolumn=yes")
cmd("set smartindent")
cmd("set smarttab")
cmd("set splitbelow")
cmd("set splitright")
cmd("set t_Co=256")
cmd("set tabstop=4")
cmd("set termguicolors")
cmd("set timeoutlen=100")
cmd("set updatetime=300")

-- transparent neovim
cmd("au ColorScheme * hi Normal ctermbg=none guibg=none")

-- import filetypes
cmd([[
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
au BufRead,BufNewFile *.ves set filetype=vesti
au BufRead,BufNewFile *.glasm set filetype=glasm
au BufRead,BufNewFile *.asm set filetype=nasm
filetype plugin indent on

augroup remember_folds
  autocmd!
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent! loadview
augroup END
]])

--------------------------------------------------
--  Theme Setting
--------------------------------------------------
cmd("let base16colorspace=256")
cmd("set termguicolors")
cmd("colorscheme base16-gruvbox-dark-pale")

--------------------------------------------------
--  Keybindings (Basic)
--------------------------------------------------
-- mapping keymaps helper function
function keybind(mode, key, mapsto, is_noremap)
	vim.keymap.set(mode, key, mapsto, { noremap = is_noremap })
end

-- Better Indenting
keybind("v", "<", "<gv", false)
keybind("v", ">", ">gv", false)

-- TAB in general mode will move to next buffer
keybind("n", "<TAB>", ":bnext<CR>", false)
keybind("n", "<S-TAB>", ":bprevious<CR>", false)

-- Move selected line / block of text in visual mode
-- shift + k to move up
-- shift + j to move down
keybind("x", "K", ":move '<-2<CR>gv-gv", false)
keybind("x", "J", ":move '>+1<CR>gv-gv", false)

keybind("n", "<C-\\>", "O", false)
keybind("i", "<C-\\>", "<C-[>O", false)

-- remap Q to other one
keybind("n", "Q", "gq", false)

--------------------------------------------------
--  Keybindings (which-key)
--------------------------------------------------
local wk = require("which-key")

wk.setup({
	icons = {
		separator = "|",
	},
})
wk.register({
	["<leader>"] = {
		b = {
			name = "+buffer",
			["1"] = { "<cmd>b1<CR>", "buffer 1" },
			["2"] = { "<cmd>b2<CR>", "buffer 2" },
			["3"] = { "<cmd>b3<CR>", "buffer 3" },
			["4"] = { "<cmd>b4<CR>", "buffer 4" },
			["5"] = { "<cmd>b5<CR>", "buffer 5" },
			["?"] = { "<cmd>Telescope buffers<CR>", "show all buffers" },
			d = { "<cmd>Bdelete<CR>", "delete buffer" },
			f = { "<cmd>bfirst<CR>", "first-buffer" },
			h = { "<cmd>Startify<CR>", "home-buffer" },
			l = { "<cmd>blast<CR>", "last-buffer" },
			n = { "<cmd>bnext<CR>", "next-buffer" },
			p = { "<cmd>bprevious<CR>", "previous-buffer" },
		},
		f = {
			name = "+file",
			f = { "<cmd>Telescope find_files<CR>", "Find File" },
			b = { "<cmd>Telescope file_browser<CR>", "File Browser" },
			r = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
			n = { "<cmd>enew<CR>", "New File" },
		},
		t = {
			name = "+terminal",
			g = { "<cmd>FloatermNew --height=28 lazygit<CR>", "lazygit" },
			o = { "<cmd>FloatermNew --wintype=popup<CR>", "open a floating terminal" },
			p = { "<cmd>FloatermNew python<CR>", "python" },
		},
	},
})
--------------------------------------------------
--  Formatter
--------------------------------------------------
require("formatter").setup({
	filetype = {
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		rust = {
			function()
				return {
					exe = "rustfmt",
					stdin = true,
				}
			end,
		},
	},
})
cmd([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * FormatWrite
augroup END
]])

--------------------------------------------------
--  Ultisnips
--------------------------------------------------
g.UltiSnipsExpandTrigger = "<TAB>"
g.UltiSnipsJumpForwardTrigger = "<TAB>"
g.UltiSnipsJumpBackwardTrigger = "<S-TAB>"
g.UltiSnipsUsePythonVersion = 3

g.UltiSnipsSnippetDirectories = { "~/.config/nvim/snips" }

g.python_highlight_all = 1

--------------------------------------------------
--  nvim-comment
--------------------------------------------------
require("nvim_comment").setup({
	line_mapping = "<leader>/.",
	operator_mapping = "<leader>//",
})

--------------------------------------------------
--  ale
--------------------------------------------------
g.ale_sign_error = "!!"
g.ale_sign_warning = "<>"

--------------------------------------------------
--  Telescope
--------------------------------------------------
-- stolen from https://github.com/nvim-telescope/telescope-file-browser.nvim
require("telescope").setup({
	extensions = {
		file_browser = {
			theme = "ivy",
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			-- mappings = {
			-- 	["i"] = {
			-- 		-- your custom insert mode mappings
			-- 	},
			-- 	["n"] = {
			-- 		-- your custom normal mode mappings
			-- 	},
			-- },
		},
	},
})

require("telescope").load_extension("file_browser")
