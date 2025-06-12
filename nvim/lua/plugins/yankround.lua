return {
  "LeafCage/yankround.vim",
  event = "TextYankPost",
  keys = {
    { "p", "<Plug>(yankround-p)", mode = { "n", "x" } },
    { "P", "<Plug>(yankround-P)", mode = { "n", "x" } },
    { "gp", "<Plug>(yankround-gp)", mode = { "n", "x" } },
    { "gP", "<Plug>(yankround-gP)", mode = { "n", "x" } },
    { "<C-p>", "<Plug>(yankround-prev)", mode = "n" },
    { "<C-n>", "<Plug>(yankround-next)", mode = "n" },
  },
}
