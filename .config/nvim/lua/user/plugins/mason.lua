local M = {
  "williamboman/mason.nvim",
  build = ":MasonUpdate", -- :MasonUpdate updates registry contents
  dependencies = {
    { "williamboman/mason-lspconfig.nvim" },
  },
  opts = {
    max_concurrent_installers = 4,
  },
}

function M.config(_, opts)
  require("mason").setup(opts)
  require("mason-lspconfig").setup({
    ensure_installed = require("user.utils.servers").get_server_names(),
    automatic_installation = true,
  })
end

return M
