local M = {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = true,
  branch = "v2.x",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-tree/nvim-web-devicons" },
    { "MunifTanjim/nui.nvim" },
    {
      "s1n7ax/nvim-window-picker",
      version = "v1.*",
      config = function()
        require("window-picker").setup({
          selection_chars = "ABCDEFGHIJKL",
          filter_rules = {
            -- filter using buffer options
            bo = {
              filetype = { "neo-tree", "neo-tree-popup", "notify", "NvimTree" },
              buftype = { "terminal", "quickfix" },
            },
            -- match dracula theme for tmux
            fg_color = "#282A36",
            other_win_hl_color = "#50FA7B",
          },
        })
      end,
    },
    { "nvim-lua/plenary.nvim" },
  },
  opts = function()
    local copy_to_register = require("user.utils.copy_to_register").copy_to_register
    local Path = require("plenary.path")

    -- set colors for git status indicators
    vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { ctermbg = 0, fg = "#568752", bg = "#16161E" })
    vim.api.nvim_set_hl(0, "NeoTreeGitConflict", { ctermbg = 0, fg = "#993939", bg = "#16161E" })
    vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { ctermbg = 0, fg = "#848505", bg = "#16161E" })
    vim.api.nvim_set_hl(0, "NeoTreeGitIgnored", { ctermbg = 0, fg = "#707171", bg = "#16161E" })
    vim.api.nvim_set_hl(0, "NeoTreeGitModified", { ctermbg = 0, fg = "#6795B9", bg = "#16161E" })
    vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { ctermbg = 0, fg = "#CE675A", bg = "#16161E" })

    return {
      source_selector = {
        winbar = true, -- toggle to show selector on winbar
        show_scrolled_off_parent_node = false,
        sources = {
          {
            source = "filesystem",
            display_name = "  Files ",
          },
          {
            source = "buffers",
            display_name = "  Buffers ",
          },
          {
            source = "git_status",
            display_name = "  Git ",
          },
        },
        content_layout = "start",
        tabs_layout = "equal",
        truncation_character = "…",
        tabs_min_width = nil,
        tabs_max_width = nil,
        padding = 0,
        separator = { left = "▏", right = "▕" }, -- string | { left: string, right: string, override: string | nil }
        separator_active = nil, -- string | { left: string, right: string, override: string | nil } | nil
        show_separator_on_edge = false,
        highlight_tab = "NeoTreeTabInactive",
        highlight_tab_active = "NeoTreeTabActive",
        highlight_background = "NeoTreeTabInactive",
        highlight_separator = "NeoTreeTabSeparatorInactive",
        highlight_separator_active = "NeoTreeTabSeparatorActive",
      },
      default_component_configs = {
        use_git_status_colors = true,
        git_status = {
          symbols = {
            -- Change type. It is redundant to show the change type if you use the
            -- default behavior of highlighting the file name according to the change type
            added = "",
            deleted = "",
            modified = "",
            renamed = "",
            -- Status type
            untracked = "",
            ignored = "",
            unstaged = "󰭜",
            staged = "",
            conflict = "󱐋",
          },
        },
      },
      window = {
        mappings = {
          -- default is <space>, which conflicts with leader key
          -- https://github.com/nvim-neo-tree/neo-tree.nvim/issues/213#issuecomment-1079933513
          ["<space>"] = "none",
          -- use left/right arrows to open/close directories
          ["<Right>"] = "open_with_window_picker",
          ["<Left>"] = "close_node",
          -- allow opening files/folders with 'o'
          ["o"] = "open_with_window_picker",
          -- override to allow choosing window when opening files
          ["<cr>"] = "open_with_window_picker",
          -- remap vsplit
          ["s"] = "none",
          ["v"] = "vsplit_with_window_picker",
          -- remap split horizontal
          ["S"] = "none",
          ["-"] = "split_with_window_picker",
          -- remap toggle preview
          ["P"] = "none",
          ["T"] = "toggle_preview",
          -- show/hide relative paths
          ["m"] = {
            "move",
            config = {
              show_path = "relative", -- "none", "relative", "absolute"
            },
          },
          ["a"] = {
            "add",
            config = {
              show_path = "none", -- "none", "relative", "absolute"
            },
          },
          ["A"] = {
            "add",
            config = {
              show_path = "none", -- "none", "relative", "absolute"
            },
          },
          ["c"] = {
            "copy",
            config = {
              show_path = "relative", -- "none", "relative", "absolute"
            },
          },
        },
      },
      filesystem = {
        filtered_items = {
          visible = false, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = false,
          hide_gitignored = true,
          never_show = {
            ".DS_Store",
            "thumbs.db",
          },
        },
        -- This will find and focus the file in the active buffer every
        -- time the current file is changed while the tree is open.
        follow_current_file = true,
        -- This will use the OS level file watchers to detect changes
        -- instead of relying on nvim autocmd events.
        use_libuv_file_watcher = true,
        commands = {
          copy_absolute_path = function(state)
            local node = state.tree:get_node()
            local content_path = Path:new(node.path)
            local absolute_path = content_path:absolute()
            copy_to_register(absolute_path)
          end,
          copy_relative_path = function(state)
            local node = state.tree:get_node()
            local content_path = Path:new(node.path)
            local relative_path = content_path:make_relative()
            copy_to_register(relative_path)
          end,
          copy_filename = function(state)
            local node = state.tree:get_node()
            local content_path = Path:new(node.path)
            local path_parts = content_path:_split()
            local last_path_part = path_parts[#path_parts]
            if content_path:is_dir() then
              copy_to_register(last_path_part .. "/")
            else
              copy_to_register(last_path_part)
            end
          end,
          create_python_package = function(state)
            local add_directory = require("neo-tree.sources.common.commands").add_directory
            local utils = require("neo-tree.utils")
            local manager = require("neo-tree.sources.manager")
            local refresh = utils.wrap(manager.refresh, "buffers")
            local callback = function(new_directory)
              local new_directory_path = Path:new(new_directory)
              new_directory_path:joinpath("__init__.py"):touch()
              refresh()
            end
            add_directory(state, callback)
          end,
        },
        window = {
          mappings = {
            ["B"] = "copy_absolute_path",
            ["y"] = "copy_filename",
            ["Y"] = "copy_relative_path",
            ["P"] = "create_python_package",
          },
        },
      },
      buffers = {
        -- This will find and focus the file in the active buffer every
        -- time the current file is changed while the tree is open.
        follow_current_file = true,
      },
      git_status = {
        window = {
          mappings = {
            ["A"] = "git_add_all",
            ["gu"] = "git_unstage_file",
            ["ga"] = "git_add_file",
            ["gr"] = "git_revert_file",
            ["gc"] = "git_commit",
            ["gp"] = "git_push",
            ["gg"] = "git_commit_and_push",
          },
        },
      },
    }
  end,
  config = function(_, opts)
    -- remove the deprecated commands from v1.x
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

    require("neo-tree").setup(opts)

    -- keymaps
    local map = require("user.utils.map").map
    map("n", "<leader>e", "<Cmd>Neotree filesystem toggle left<CR>", { desc = "Toggle file (e)xplorer" })
    map("n", "<leader>s", "<Cmd>Neotree git_status toggle float<CR>", { desc = "Toggle git (s)tatus explorer" })
    map("n", "<leader>u", "<Cmd>Neotree buffers toggle right<CR>", { desc = "Toggle b(u)ffers explorer" })
  end,
}

return M
