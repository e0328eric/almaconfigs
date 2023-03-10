-- LuaFormatter off
return {
	{ "wbthomason/packer.nvim" },
	{ "RRethy/nvim-base16" },
	{ "folke/which-key.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		requires = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
		cond = vim.fn.executable("make") == 1,
	},
	{ "nvim-treesitter/nvim-treesitter" },
	{ "nvim-treesitter/playground" },
	{ "qnighy/lalrpop.vim" },
	{ "alaviss/nim.nvim" },
	{ "prabirshrestha/asyncomplete.vim" },
	{ "simrat39/rust-tools.nvim" },
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "theprimeagen/harpoon" },
	{ "hoob3rt/lualine.nvim" },
	{ "akinsho/bufferline.nvim", tag = "v3.*" },
	{ "nvim-tree/nvim-web-devicons" },
	{ "nvim-tree/nvim-tree.lua" },
	{ "mg979/vim-visual-multi", branch = "master" },
	{ "akinsho/toggleterm.nvim" },
	{ "mbbill/undotree" },
	{ "norcalli/nvim-colorizer.lua" },
	{ "j-hui/fidget.nvim" },
	{ "mhartington/formatter.nvim" },
	{ "LudoPinelli/comment-box.nvim" },
	{
		"nvim-neorg/neorg",
		requires = "nvim-lua/plenary.nvim",
	},
	{
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
	},
	{
		"saecki/crates.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup()
		end,
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" }, -- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" }, -- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	},
}
-- LuaFormatter on
