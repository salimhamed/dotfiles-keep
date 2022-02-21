M = {
  "github/copilot.vim",
  enabled = require("user.utils.project_settings").is_copilot_vim_enabled,
  build = ":Copilot setup",
  config = function()
    vim.g.copilot_no_tab_map = true
    -- copilot doesn't play well with dap-ui repl
    -- see, https://github.com/rcarriga/nvim-dap-ui/issues/102#issuecomment-1153199899
    vim.g.copilot_filetypes = { ["dap-repl"] = false }
    local map = require("user.utils.map").map

    -- accept
    local function accept()
      local copilot_keys = vim.fn["copilot#Accept"]()
      vim.api.nvim_feedkeys(copilot_keys, "i", true)
    end
    map("i", "<M-n>", accept, { desc = "Accept Copilot suggestion" })

    -- remap dismiss
    vim.cmd([[imap <M-e> <C-]>]])

    -- remap suggest
    vim.cmd([[imap <M-Space> <M-Bslash>]])
  end,
}

return M
