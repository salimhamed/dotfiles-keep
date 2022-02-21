return {
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    lazy = true,
    build = "cd app && npm install && git reset --hard",
    config = function()
      local map = require("user.utils.map").map
      map("n", "<Leader>mp", "<Cmd>MarkdownPreview<CR>", { noremap = false, desc = "Start markdown (p)review" })
      map("n", "<Leader>ms", "<Cmd>MarkdownPreviewStop<CR>", { noremap = false, desc = "(s)top markdown preview" })
    end,
  },
}
