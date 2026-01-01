return {
  "mhiro2/pinwords.nvim",
  event = "VeryLazy",
  config = function()
    local pinwords = require("pinwords")
    local map = vim.keymap.set

    pinwords.setup()
    map("n", "qj", pinwords.set, { desc = "Pin word" })
    map("x", "qj", ":PinWord<cr>", { desc = "Pin selection" })
    map("n", "ql", pinwords.cword_toggle, { desc = "Toggle cword highlight" })
  end,
}
