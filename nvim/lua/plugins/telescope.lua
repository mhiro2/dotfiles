return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = "VimEnter",
  config = function()
    require("telescope").setup()

    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "zf", builtin.find_files, {})
    vim.keymap.set("n", "zg", builtin.live_grep, {})
    vim.keymap.set("n", "zb", builtin.buffers, {})
  end,
}
