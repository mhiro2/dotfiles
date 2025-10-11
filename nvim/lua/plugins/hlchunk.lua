return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    chunk = {
      enable = true,
      use_treesitter = false,
    },
    indent = {
      enable = true,
    },
    line_num = {
      enable = false,
    },
    blank = {
      enable = false,
    },
  },
  config = function(_, opts)
    require("hlchunk").setup(opts)
  end,
}
