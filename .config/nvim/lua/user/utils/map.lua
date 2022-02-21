local M = {}

function M.map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts = vim.tbl_extend("keep", opts, { silent = true, noremap = true })
  vim.keymap.set(mode, lhs, rhs, opts)
end

return M
