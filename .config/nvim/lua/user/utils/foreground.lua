M = {}

function M.get_foreground_color_by_name(name)
  local hl = vim.api.nvim_get_hl(0, { name = name })
  local fg = hl.fg or hl.foreground
  return fg and { fg = string.format("#%06x", fg) }
end

return M
