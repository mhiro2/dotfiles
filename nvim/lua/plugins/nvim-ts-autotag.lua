return {
  "windwp/nvim-ts-autotag",
  event = "InsertEnter",
  dependencies = { "windwp/nvim-autopairs" },
  config = function()
    require("nvim-ts-autotag").setup()
  end,
}
