local M = {
  "nvim-tree/nvim-tree.lua",
  enabled = false,
  opts = {
    filters = {
      dotfiles = false,
      custom = { "^.DS_Store$" },
    },
  },
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
  },
}

function M.config(_, opts)
  require("nvim-tree").setup(opts)

  -- open nvim tree on startup if the current buffer is a directory
  local function open_nvim_tree(data)
    local directory = vim.fn.isdirectory(data.file) == 1
    if not directory then
      return
    end
    -- change to the directory
    vim.cmd.cd(data.file)
    -- open the tree
    require("nvim-tree.api").tree.open()
  end

  vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

  -- keymaps
  local map = require("user.utils.map").map
  map("n", "<leader>e", "<Cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
end

return M
