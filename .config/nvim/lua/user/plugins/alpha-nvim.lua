M = {
  "goolord/alpha-nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
  },
  opts = function()
    local config = require("alpha.themes.startify").config
    local header = {
      type = "text",
      val = {
        [[             ____________________________________________________]],
        [[            /                                                    \]],
        [[           |    _____________________________________________     |]],
        [[           |   |                                             |    |]],
        [[           |   |  Welcome to Neovim.                         |    |]],
        [[           |   |                                             |    |]],
        [[           |   |                                             |    |]],
        [[           |   |  Remember...                                |    |]],
        [[           |   |  You are doing a great fucking job. 🤟      |    |]],
        [[           |   |                                             |    |]],
        [[           |   |_____________________________________________|    |]],
        [[           |                                                      |]],
        [[            \_____________________________________________________/]],
        [[                   \_______________________________________/]],
        [[                _______________________________________________]],
        [[             _-'    .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.  --- `-_]],
        [[          _-'.-.-. .---.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.--.  .-.-.`-_]],
        [[       _-'.-.-.-. .---.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-`__`. .-.-.-.`-_]],
        [[    _-'.-.-.-.-. .-----.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-----. .-.-.-.-.`-_]],
        [[ _-'.-.-.-.-.-. .---.-. .-----------------------------. .-.---. .---.-.-.-.`-_]],
        [[:-----------------------------------------------------------------------------:]],
        [[`---._.-----------------------------------------------------------------._.---']],
      },
      opts = {
        hl = "Type",
        shrink_margin = false,
      },
    }
    config.layout[2] = header
    return config
  end,
  config = function(_, opts)
    require("alpha").setup(opts)
  end,
}

return M
