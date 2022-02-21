local M = {
  "folke/tokyonight.nvim",
  branch = "main",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- default is 50, recommended to set to a high number for colorschemes
  opts = {
    style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    transparent = false, -- Enable this to disable setting the background color
    terminal_colors = false, -- Configure the colors used when opening a `:terminal` in Neovim
    styles = {
      sidebars = "dark", -- style for sidebars, see below
      floats = "dark", -- style for floating windows
    },
    sidebars = { "qf", "help", "lazy", "toggleterm", "trouble", "neo-tree" },
  },
}

M.colorscheme_name = "tokyonight-night"

M.config = function(_, opts)
  require("tokyonight").setup(opts)
  vim.cmd.colorscheme(M.colorscheme_name)
end

return M
