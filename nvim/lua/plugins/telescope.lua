return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = "Telescope",
  keys = {
    {
      "zf",
      function()
        require("telescope.builtin").find_files()
      end,
      desc = "Telescope Find Files",
      mode = "n",
    },
    {
      "zg",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "Telescope Live Grep",
      mode = "n",
    },
    {
      "zb",
      function()
        require("telescope.builtin").buffers()
      end,
      desc = "Telescope Buffers",
      mode = "n",
    },
  },
  config = function()
    require("telescope").setup()
  end,
}
