# Vendored Tree-sitter Queries

このディレクトリ配下の query は `nvim-treesitter` から切り出して管理する。

- Source repository: `nvim-treesitter/nvim-treesitter`
- Source commit: `4916d6592ede8c07973490d9322f187e07dfefac`
- Languages: `bash`, `comment`, `ecma`, `go`, `hcl`, `html`, `html_tags`, `javascript`, `jsx`, `python`, `rust`, `terraform`, `toml`, `tsx`, `typescript`

`hcl` と `html_tags` は parser を持たない query 専用の言語で、それぞれ `terraform` と `html` から `; inherits:` で参照される。

`nvim/parser` の parser と組み合わせて、Neovim core の `vim.treesitter` だけで動かす前提。
