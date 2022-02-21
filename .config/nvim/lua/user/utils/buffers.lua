M = {}

local function split_and_move(vsplit)
  local start_window = vim.api.nvim_get_current_win()

  -- open buffer in new window
  if vsplit then
    vim.cmd("vertical sbuffer")
  else
    vim.cmd("sbuffer")
  end
  local new_window = vim.api.nvim_get_current_win()

  -- move to the next buffer in the starting window
  vim.api.nvim_set_current_win(start_window)
  vim.cmd("BufferPrevious")

  -- select the new window
  vim.api.nvim_set_current_win(new_window)
end

function M.v_split_and_move()
  split_and_move(true)
end

function M.h_split_and_move()
  split_and_move(false)
end

return M
