local M = {
  "folke/which-key.nvim",
  opts = {
    defaults = {
      ["g"] = { name = "+goto" },
      ["]"] = { name = "+next" },
      ["["] = { name = "+prev" },
      -- surround
      ["cs"] = { name = "+change surround" },
      ["ds"] = { name = "+delete surround" },
      ["ys"] = { name = "+add surround" },
      -- leader keymap definitions
      ["<Leader>b"] = { name = "+buffers" },
      ["<Leader>c"] = { name = "+code" },
      ["<Leader>d"] = { name = "+debug" },
      ["<Leader>f"] = { name = "+find" },
      ["<Leader>g"] = { name = "+git" },
      ["<Leader>h"] = { name = "+harpoon" },
      ["<Leader>q"] = { name = "+sessions" },
      ["<Leader>x"] = { name = "+trouble" },
      ["<Leader>fy"] = { name = "+yadm" },
    },
    popup_mappings = {
      scroll_down = "<c-d>", -- binding to scroll down inside the popup
      scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
      border = "shadow", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
      padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
      zindex = 1000, -- positive value to position WhichKey above other floating windows.
    },
  },
}

function M.config(_, opts)
  local map = require("user.utils.map").map
  vim.o.timeout = true
  vim.o.timeoutlen = 500 -- time before whichkey popup is displayed
  require("which-key").setup(opts)
  require("which-key").register(opts.defaults)
  local which_key_show = require("which-key").show_command
  map("n", "<Leader>w", which_key_show, { desc = "WhichKey" })
end

return M
