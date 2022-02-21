local M = {
  "smoka7/hop.nvim",
  version = "*",
  opts = {},
}

function M.config(_, opts)
  local hop = require("hop")
  hop.setup(opts)

  local map = require("user.utils.map").map
  local directions = require("hop.hint").HintDirection

  local function forward()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
  end

  local function backward()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
  end

  map("n", "<Leader>J", backward, { desc = "(J)ump backward" })
  map("n", "<Leader>j", forward, { desc = "(j)ump forward" })
end

return M
