return {
  "lambdalisue/fern.vim",
  dependencies = {
    "lambdalisue/fern-git-status.vim",
    "lambdalisue/fern-hijack.vim",
    "lambdalisue/fern-renderer-nerdfont.vim",
    "lambdalisue/nerdfont.vim",
  },
  cmd = "Fern",
  keys = {
    {
      "<space>f",
      "<cmd>Fern . -drawer -reveal=% -toggle -stay -width=40<CR>",
      desc = "Toggle Fern drawer",
      mode = "n",
      silent = true,
    },
  },
  config = function()
    vim.g["fern#renderer"] = "nerdfont"
    vim.g["fern#default_hidden"] = 1
  end,
}
