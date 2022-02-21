local M = {
  "christoomey/vim-tmux-navigator",
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
  config = function()
    local map = require("user.utils.map").map

    map("n", "<C-h>", vim.cmd.TmuxNavigateLeft, { desc = "Move to window left" })
    map("n", "<C-j>", vim.cmd.TmuxNavigateDown, { desc = "Move to window below" })
    map("n", "<C-k>", vim.cmd.TmuxNavigateUp, { desc = "Move to window above" })
    map("n", "<C-l>", vim.cmd.TmuxNavigateRight, { desc = "Move to window right" })

    -- since vim-tmux-navigator hijacks C+l to clear the screen, set a different keybinding
    map("t", "<leader><C-l>", ':call term_sendkeys("", "\\<C-L>")<CR>', { desc = "Clear terminal" })
  end,
}

return M
