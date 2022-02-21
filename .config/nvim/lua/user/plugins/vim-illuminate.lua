local M = {
  "RRethy/vim-illuminate",
  opts = {
    providers = {
      "lsp",
      "treesitter",
      "regex",
    },
    delay = 100,
    filetypes_denylist = {
      "alpha",
      "NvimTree",
      "neo-tree",
    },
    -- do not illuminate in visual modes
    modes_denylist = { "V", "v", "vs", "Vs", "CTRL-V", "CTRL-Vs" },
    -- under_cursor: whether or not to illuminate under the cursor
    under_cursor = true,
  },
}

function M.config(_, opts)
  require("illuminate").configure(opts)
end

return M
