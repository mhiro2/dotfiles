return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  opts = function()
    local function has_biome_config(bufnr)
      local name = vim.api.nvim_buf_get_name(bufnr)
      if name == "" then
        name = vim.uv.cwd()
      end
      local search_path = vim.fs.dirname(name) or name
      local found = vim.fs.find({ "biome.json", "biome.jsonc" }, {
        path = search_path,
        upward = true,
        stop = vim.uv.os_homedir(),
      })
      return #found > 0
    end

    local function biome_or_oxfmt(bufnr)
      if has_biome_config(bufnr) then
        return { "biome" }
      end
      return { "oxfmt" }
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

        javascript = biome_or_oxfmt,
        typescript = biome_or_oxfmt,
        javascriptreact = biome_or_oxfmt,
        typescriptreact = biome_or_oxfmt,
        json = biome_or_oxfmt,

        ["*"] = { "trim_newlines", "trim_whitespace" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    }
  end,
}
