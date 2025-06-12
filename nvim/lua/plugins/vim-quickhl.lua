return {
  "t9md/vim-quickhl",
  event = "VimEnter",
  keys = {
    { "qj", "<Plug>(quickhl-manual-this)", mode = { "n", "x" } },
    { "qJ", "<Plug>(quickhl-manual-reset)", mode = { "n", "x" } },
    { "ql", "<Plug>(quickhl-cword-toggle)", mode = "n" },
  },
}
