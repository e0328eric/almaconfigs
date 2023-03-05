return {
  -- {
  --   "folke/tokyonight.nvim",
  --   opts = {
  --     style = "night",
  --     transparent = false,
  --     -- styles = {
  --     --   sidebars = "transparent",
  --     --   floats = "transparent",
  --     -- },
  --   },
  -- },
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    config = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      transparent_background = true,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.45,
      },
      term_colors = true,
      color_overrides = {
        mocha = {
          base = "#1A1A2F",
        },
      },
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = { "italic" },
        keywords = { "bold" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        dashboard = true,
        telescope = true,
        which_key = true,
        treesitter = true,
        hop = true,
        mason = true,
        ts_rainbow = true,
        noice = true,
        notify = true,
        lsp_saga = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = true,
        },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
    },
  },
}
