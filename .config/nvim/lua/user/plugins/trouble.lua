M = {
  "folke/trouble.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
  },
  opts = {
    use_diagnostic_signs = true,
  },
  config = function(_, opts)
    require("trouble").setup(opts)

    -- keymappings
    local map = require("user.utils.map").map
    map("n", "<leader>xx", "<Cmd>TroubleToggle<CR>", { desc = "Toggle trouble (x)" })
    map("n", "<leader>xw", "<Cmd>TroubleToggle workspace_diagnostics<CR>", { desc = "Toggle (w)orkspace diagnostics" })
    map("n", "<leader>xd", "<Cmd>TroubleToggle document_diagnostics<CR>", { desc = "Toggle (d)ocument diagnostics" })
    map("n", "<leader>xl", "<Cmd>TroubleToggle loclist<CR>", { desc = "Toggle (l)ocation list" })
    map("n", "<leader>xq", "<Cmd>TroubleToggle quickfix<CR>", { desc = "Toggle (q)uickfix list" })
  end,
}

return M
