return {
  "karb94/neoscroll.nvim",
  event = "VeryLazy",
  config = function()
    local neoscroll = require("neoscroll")
    neoscroll.setup({
      mappings = { "<C-b>", "<C-f>" },
    })

    local keymaps = {
      ["<C-b>"] = function()
        neoscroll.ctrl_b({ duration = 250, easing = "linear" })
      end,
      ["<C-f>"] = function()
        neoscroll.ctrl_f({ duration = 250, easing = "linear" })
      end,
    }
    local modes = { "n", "v", "x" }

    for key, func in pairs(keymaps) do
      vim.keymap.set(modes, key, func)
    end
  end,
}
