local M = {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = function()
    local color_opts = require("user.plugins.colorscheme").opts
    local colors = require("tokyonight.colors").setup(color_opts)
    return {
      size = 20,
      open_mapping = "<F12>",
      hide_numbers = true,
      shade_terminals = false,
      highlights = {
        Normal = {
          guibg = colors.bg_dark,
        },
      },
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "horizontal",
      close_on_exit = true,
      shell = "zsh",
      float_opts = {
        border = "curved",
      },
    }
  end,
}

function M.config(_, opts)
  require("toggleterm").setup(opts)

  -- Mappings to make moving in/out of terminal easier once toggled, while keeping it open
  function _G.set_terminal_keymaps()
    vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { buffer = 0 })
    vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { buffer = 0 })
    vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { buffer = 0 })
    vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { buffer = 0 })
  end
  vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

  local Terminal = require("toggleterm.terminal").Terminal

  local lg_opts = {
    close_on_exit = true,
    hidden = true,
    direction = "float",
    auto_scroll = false,
    float_opts = {
      border = "single",
    },
    on_open = function()
      -- make sure to start in insert mode
      vim.cmd("startinsert!")
    end,
  }

  -- function for opening lazygit in terminal
  function _LAZYGIT_TOGGLE()
    local terminal = Terminal:new(vim.tbl_extend("error", lg_opts, { cmd = "lazygit" }))
    terminal:toggle()
  end

  -- function for opening lazyyaml in terminal
  function _LAZYYADM_TOGGLE()
    local terminal = Terminal:new(vim.tbl_extend("error", lg_opts, {
      cmd = [[
	lazygit \
	  --use-config-file "${HOME}/.config/nvim/lazygit.yml" \
	  --work-tree "${HOME}" \
	  --git-dir "${HOME}/.local/share/yadm/repo.git"
      ]],
    }))
    terminal:toggle()
  end
end

return M
