return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "comment",
        "go",
        "html",
        "javascript",
        "markdown",
        "python",
        "rust",
        "terraform",
        "tsx",
        "typescript",
      },
      highlight = { enable = true },
      indent = { enable = true },
      matchup = { enable = true },
    })
  end,
}
