return {
  "gbprod/yanky.nvim",
  event = "TextYankPost",
  keys = {
    { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" } },
    { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" } },
    { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" } },
    { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" } },
    { "<C-p>", "<Plug>(YankyCycleBackward)", mode = "n" },
    { "<C-n>", "<Plug>(YankyCycleForward)", mode = "n" },
  },
  config = function()
    require("yanky").setup()
  end,
}
