return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    picker = { enabled = true },
  },
  keys = {
    {
      "zf",
      function()
        Snacks.picker.files()
      end,
      desc = "Snacks Find Files",
      mode = "n",
    },
    {
      "zg",
      function()
        Snacks.picker.grep()
      end,
      desc = "Snacks Live Grep",
      mode = "n",
    },
    {
      "zb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Snacks Buffers",
      mode = "n",
    },
  },
}
