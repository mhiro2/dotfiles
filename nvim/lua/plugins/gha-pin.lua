return {
  "mhiro2/gha-pin.nvim",
  config = function()
    require("gha-pin").setup({
      auto_check = { enabled = true },
      minimum_release_age_seconds = 604800,
    })
  end,
}
