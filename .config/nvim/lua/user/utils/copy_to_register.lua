M = {}

function M.copy_to_register(content)
  -- copy to unnamed register
  vim.fn.setreg('"', content)

  -- copy to first number register
  vim.fn.setreg("1", content)

  -- copy to clipboard register
  vim.fn.setreg("+", content)
end

return M
