M = {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {
    options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" },
    -- integration with barbar
    -- https://github.com/romgrk/barbar.nvim#persistencenvim
    pre_save = function()
      vim.api.nvim_exec_autocmds("User", { pattern = "SessionSavePre" })
    end,
  },
  keys = {
    {
      "<Leader>qs",
      function()
        require("persistence").load()
      end,
      desc = "Restore (s)ession for the current directory",
    },
    {
      "<Leader>ql",
      function()
        require("persistence").load({ last = true })
      end,
      desc = "Restore (l)ast session",
    },
    {
      "<Leader>qd",
      function()
        require("persistence").stop()
      end,
      desc = "(d)o not save current session",
    },
  },
  config = function()
    require("persistence").setup()
  end,
}

return M
