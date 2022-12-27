-- Install Packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
end

require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	-- begin packages list

	-- Base16 Theme
	use("RRethy/nvim-base16")

	-- Fuzzy Finder (files, lsp, etc)
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } })
	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable("make") == 1 })

	-- Tree-Sitter
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	use("nvim-treesitter/playground")

	-- Make verticle lines for specifing indents.
	use("lukas-reineke/indent-blankline.nvim")

	-- which key
	use("folke/which-key.nvim")

	-- harpoon
	use("theprimeagen/harpoon")

	-- lualine
	use("hoob3rt/lualine.nvim")

	-- bufferline
	use({ "akinsho/bufferline.nvim", tag = "v3.*" })

	-- nvim-tree
	use("nvim-tree/nvim-web-devicons")
	use("nvim-tree/nvim-tree.lua")

	-- vim-visual-multi
	use({ "mg979/vim-visual-multi", branch = "master" })

	-- toogleterm
	use("akinsho/toggleterm.nvim")

	-- undo-tree
	use("mbbill/undotree")

	-- vim-fugitive
	use("tpope/vim-fugitive")

	-- colorizer
	use("norcalli/nvim-colorizer.lua")

	-- vesti highlight
	use("e0328eric/vesti-vim")

	-- fidget
	use("j-hui/fidget.nvim")

	-- formatter
	use("mhartington/formatter.nvim")

	-- comment box
	use("LudoPinelli/comment-box.nvim")

	-- LSP Zero
	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})

	-- end of the list
end)
