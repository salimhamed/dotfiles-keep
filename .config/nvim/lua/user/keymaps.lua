local map = require("user.utils.map").map

-- lazygit
map("n", "<leader>gl", "<Cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "Open (l)azygit" })
map("n", "<leader>gy", "<Cmd>lua _LAZYYADM_TOGGLE()<CR>", { desc = "Open lazygit for (y)adm files" })

-- bind nohl to remove highlight of your last search
map("n", "<C-n>", "<Cmd>nohl<CR>", { desc = "Remove highlight of last search" })
map("v", "<C-n>", ":nohl<CR>", { desc = "Remove highlight of last search" })
map("i", "<C-n>", "<C-o><Cmd>nohl<CR>", { desc = "Remove highlight of last search" })

-- easier moving of code blocks
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Resize with arrows
map("n", "<S-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
map("n", "<S-Up>", ":resize +2<CR>", { desc = "Increase window height" })
map("n", "<S-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<S-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Keep cursor centered when moving 1/2 pages
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Keep cursor centered when moving through search results and open folds
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Better paste
map("v", "p", '"_dP')

-- Better quit
local function save_and_quit()
  vim.cmd("wa")
  vim.cmd("qa")
end
map("n", "<C-q>", save_and_quit, { desc = "Save all buffers and quit" })

-- Save current buffer
map("n", "<C-s>", "<Cmd>w<CR>", { desc = "Save current buffer" })
