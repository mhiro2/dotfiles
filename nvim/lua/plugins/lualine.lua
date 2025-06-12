return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local lualine = require("lualine")

    lualine.setup({
      options = {
        theme = "sonokai",
      },
      sections = {
        lualine_c = {
          {
            "filename",
            symbols = {
              readonly = "",
            },
          },
        },
      },
    })
  end,
}
