return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  opts = function()
    local function biome_or_prettier()
      if vim.fn.filereadable("biome.json") == 1 or vim.fn.filereadable("biome.jsonc") == 1 then
        return { "biome" }
      else
        return { "prettier" }
      end
    end

    return {
      formatters_by_ft = {
        css = { "prettier" },
        go = { "goimports" },
        html = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        python = { "ruff_format" },
        sql = { "sqlfmt" },
        terraform = { "terraform_fmt" },
        yaml = { "prettier" },

        javascript = biome_or_prettier,
        typescript = biome_or_prettier,
        javascriptreact = biome_or_prettier,
        typescriptreact = biome_or_prettier,
        json = biome_or_prettier,

        ["*"] = { "typos", "trim_newlines", "trim_whitespace" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    }
  end,
}
