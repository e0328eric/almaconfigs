return {
  {
    "RRethy/nvim-base16",
  },
  {
    "LazyVim/LazyVim",
    config = function()
      vim.cmd("colorscheme base16-ayu-dark")
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end,
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
    },
  },
}
