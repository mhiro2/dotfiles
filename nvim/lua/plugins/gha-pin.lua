return {
  "mhiro2/gha-pin.nvim",
  config = function()
    require("gha-pin").setup({
      auto_check = { enabled = true },
    })
  end,
}
