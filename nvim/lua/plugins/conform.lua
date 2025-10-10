return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  opts = function()
    local function has_biome_config(bufnr)
      local name = vim.api.nvim_buf_get_name(bufnr)
      if name == "" then
        name = vim.loop.cwd()
      end
      local search_path = vim.fs.dirname(name) or name
      local found = vim.fs.find({ "biome.json", "biome.jsonc" }, {
        path = search_path,
        upward = true,
        stop = vim.loop.os_homedir(),
      })
      return #found > 0
    end

    local function biome_or_prettier(bufnr)
      if has_biome_config(bufnr) then
        return { "biome" }
      end
      return { "prettier" }
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
