return {
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
    event = "VeryLazy",
    keys = function()
      local wk = require("which-key")
      wk.register({
        m = {
          name = "+markdown",
          p = {
            "<Plug>MarkdownPreview",
            "Open Markdown Preview",
          },
          s = {
            "<Plug>MarkdownPreviewStop",
            "Close Markdown Preview",
          },
          t = {
            "<Plug>MarkdownPreviewStop",
            "Toggle Markdown Preview",
          },
        },
      }, { prefix = "<leader>" })
    end,
  },
}
