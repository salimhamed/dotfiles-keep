local M = {
  "romgrk/barbar.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
}

function M.config(_, _)
  require("barbar").setup()
  local h_split_and_move = require("user.utils.buffers").h_split_and_move
  local v_split_and_move = require("user.utils.buffers").v_split_and_move

  local map = require("user.utils.map").map

  -- moving between buffers
  map("n", "<S-l>", "<Cmd>BufferNext<CR>", { desc = "Next buffer" })
  map("n", "<S-h>", "<Cmd>BufferPrevious<CR>", { desc = "Previous buffer" })

  -- moving between buffers
  map("n", "<leader>bd", "<Cmd>BufferClose<CR>", { desc = "(d)elete current buffer" })
  map("n", "<leader>bp", "<Cmd>BufferPin<CR>", { desc = "(p)in current buffer" })
  map("n", "<leader>ba", "<Cmd>BufferCloseAllButCurrentOrPinned<CR>", { desc = "Close (a)ll but current buffer" })
  map("n", "<leader>bl", "<Cmd>BufferCloseBuffersLeft<CR>", { desc = "Close buffers to the (l)eft" })
  map("n", "<leader>br", "<Cmd>BufferCloseBuffersRight<CR>", { desc = "Close buffers to the (r)ight" })

  map("n", "<leader>bv", v_split_and_move, { desc = "Split and Move Right" })
  map("n", "<leader>b-", h_split_and_move, { desc = "Split and Move Down" })
end

return M
