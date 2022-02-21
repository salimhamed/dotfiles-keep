-- disabling netrw at the start of init.lua is strongly advised for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- define leader key as early as possible
vim.g.mapleader = " "

-- globals
require("user.globals")

-- user settings
require("user.options")
require("user.keymaps")

-- install plugins
require("user.lazy_setup")
