return {
  "mhiro2/peekstack.nvim",
  config = function()
    local peekstack = require("peekstack")
    peekstack.setup({
      picker = {
        backend = "snacks",
      },
    })

    vim.keymap.set("n", "gpd", function()
      peekstack.peek.definition()
    end)
  end,
}
