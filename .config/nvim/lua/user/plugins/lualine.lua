local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
  },
  opts = function()
    local get_foreground_color = require("user.utils.foreground").get_foreground_color_by_name
    local colors = {
      [""] = get_foreground_color("Special"),
      ["Normal"] = get_foreground_color("Special"),
      ["Warning"] = get_foreground_color("DiagnosticError"),
      ["InProgress"] = get_foreground_color("DiagnosticWarn"),
    }

    local is_copilot_lua_enabled_in_settings = require("user.utils.project_settings").is_copilot_lua_enabled
    local have_copilot_lua, copilot_lua_api = pcall(require, "copilot.api")
    local copilot_lua_component = {
      function()
        if have_copilot_lua then
          local icon = " Copilot Lua"
          local status = copilot_lua_api.status.data
          return icon .. (status.message or "")
        end
        return ""
      end,
      cond = function()
        if is_copilot_lua_enabled_in_settings then
          local ok, clients = pcall(vim.lsp.get_active_clients, { name = "copilot", bufnr = 0 })
          return ok and #clients > 0
        end
        return false
      end,
      color = function()
        if have_copilot_lua then
          local status = require("copilot.api").status.data
          return colors[status.status] or colors[""]
        end
        return colors[""]
      end,
    }

    local is_copilot_vim_enabled_in_settings = require("user.utils.project_settings").is_copilot_vim_enabled
    local have_copilot_vim = pcall(vim.fn["copilot#Enabled"])
    local copilot_vim_component = {
      function()
        return " Copilot Vim"
      end,
      cond = function()
        return is_copilot_vim_enabled_in_settings and have_copilot_vim and vim.fn["copilot#Enabled"]() == 1
      end,
      color = function()
        return colors["Normal"]
      end,
    }

    return {
      options = {
        theme = "tokyonight",
        disabled_filetypes = {
          statusline = { "NvimTree", "neo-tree" },
          winbar = { "NvimTree", "neo-tree" },
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          {
            "filename",
            file_status = true, -- displays file status (readonly status, modified status)
            path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
          },
        },
        lualine_x = {
          "encoding",
          copilot_lua_component,
          copilot_vim_component,
          "fileformat",
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      extensions = { "quickfix" },
    }
  end,
}

function M.config(_, opts)
  require("lualine").setup(opts)
end

return M
