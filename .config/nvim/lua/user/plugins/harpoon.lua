local M = {
  "ThePrimeagen/harpoon",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
}

function M.config(_, _)
  require("harpoon").setup()

  local map = require("user.utils.map").map

  local function add_file()
    require("harpoon.mark").add_file()
    print("Harpooned current buffer")
  end

  local toggle_quick_menu = require("harpoon.ui").toggle_quick_menu
  local nav_next = require("harpoon.ui").nav_next
  local nav_prev = require("harpoon.ui").nav_prev
  local nav_file = require("harpoon.ui").nav_file

  local function create_nav_file(num)
    return function()
      nav_file(num)
    end
  end

  map("n", "<Leader>hh", add_file, { desc = "(h)arpoon file" })
  map("n", "<Leader>hv", toggle_quick_menu, { desc = "(v)iew harpooned files" })
  map("n", "<Leader>hn", nav_next, { desc = "(n)ext harpooned file" })
  map("n", "<Leader>hp", nav_prev, { desc = "(p)revious harpooned file" })

  map("n", "<Leader>h1", create_nav_file(1), { desc = "Open (1)st harpooned file" })
  map("n", "<Leader>h2", create_nav_file(2), { desc = "Open (2)nd harpooned file" })
  map("n", "<Leader>h3", create_nav_file(3), { desc = "Open (3)rd harpooned file" })
  map("n", "<Leader>h4", create_nav_file(4), { desc = "Open (4)th harpooned file" })
  map("n", "<Leader>h5", create_nav_file(5), { desc = "Open (5)th harpooned file" })
end

return M
