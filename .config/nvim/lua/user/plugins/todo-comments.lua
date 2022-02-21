local M = {
  "folke/todo-comments.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
  config = function()
    require("todo-comments").setup()
    local map = require("user.utils.map").map
    map("n", "<leader>ft", "<Cmd>TodoTelescope<Cr>", { desc = "Find (t)odos" })
  end,
}

return M
