return {
  "lambdalisue/fern.vim",
  dependencies = {
    "lambdalisue/fern-git-status.vim",
    "lambdalisue/fern-hijack.vim",
    "lambdalisue/fern-renderer-nerdfont.vim",
    "lambdalisue/nerdfont.vim",
  },
  event = "VimEnter",
  config = function()
    vim.g["fern#renderer"] = "nerdfont"
    vim.keymap.set(
      "n",
      "<space>f",
      ":Fern . -drawer -reveal=% -toggle -stay -width=40<CR>",
      { noremap = true, silent = true }
    )
  end,
}
