return {
  "windwp/nvim-ts-autotag",
  event = "InsertEnter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "windwp/nvim-autopairs",
  },
  config = function()
    require("nvim-ts-autotag").setup()
  end,
}
