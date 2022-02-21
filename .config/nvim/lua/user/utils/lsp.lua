M = {}

local builtin = require("telescope.builtin")

function M.hover_information()
  vim.lsp.buf.hover()
end

function M.definitions()
  vim.lsp.buf.definition({
    on_list = function(data)
      if #data.items > 1 then
        builtin.lsp_definitions()
      else
        vim.lsp.buf.definition({ reuse_win = true })
      end
    end,
  })
end

function M.declarations()
  vim.lsp.buf.declaration({ reuse_win = true })
end

function M.implementations()
  builtin.lsp_implementations()
  -- native alternate
  -- vim.lsp.buf.implementation
end

function M.type_definitions()
  builtin.lsp_type_definitions()
  -- native alternate
  -- vim.lsp.buf.type_definition
end

function M.references()
  builtin.lsp_references()
  -- native alternate
  -- vim.lsp.buf.references
end

function M.signature_help()
  vim.lsp.buf.signature_help()
end

function M.incremental_rename()
  local inc_rename = require("inc_rename")
  return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
end

function M.format()
  -- using lukas-reineke/lsp-format.nvim function for formatting
  -- see ./null-ls.lua for configuration
  return "<Cmd>Format<CR>"
end

function M.code_action()
  vim.lsp.buf.code_action()
end

function M.source_code_action()
  vim.lsp.buf.code_action({
    context = {
      only = {
        "source",
      },
      diagnostics = {},
    },
  })
end

function M.diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

function M.open_diagnostic_float()
  vim.diagnostic.open_float()
end

local diagnositics_enabled = true
function M.toggle_diagnostics()
  diagnositics_enabled = not diagnositics_enabled
  if diagnositics_enabled then
    vim.diagnostic.enable()
  else
    vim.diagnostic.disable()
  end
end

return M
