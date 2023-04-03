-- NOTE: Description
--
-- You can also add new plugins here as well:
-- Add plugins, the lazy syntax
-- "andweeb/presence.nvim",
-- {
--   "ray-x/lsp_signature.nvim",
--   event = "BufRead",
--   config = function()
--     require("lsp_signature").setup()
--   end,
-- },
return {
  "numToStr/Comment.nvim",
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "User AstroFile",
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    event = "User AstroFile",
  },
  {
    "saecki/crates.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("crates").setup() end,
    lazy = false,
  },
}
