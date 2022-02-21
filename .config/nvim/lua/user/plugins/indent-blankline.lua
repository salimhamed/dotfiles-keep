local M = {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
}

function M.config(_, opts)
  -- show special characters for whitespace characters
  vim.opt.list = true

  -- display spaces with a "." character
  vim.opt.listchars:append("space:⋅")

  -- configure indent-blankline
  require("ibl").setup(opts)
end

return M
