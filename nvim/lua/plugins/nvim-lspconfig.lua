return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufAdd", "BufNewFile" },
  dependencies = {
    {
      "mason-org/mason.nvim",
      config = true,
      build = ":MasonUpdate",
    },
    {
      "mason-org/mason-lspconfig.nvim",
      config = function()
        require("mason-lspconfig").setup({
          automatic_installation = true,
          ensure_installed = {
            "bashls",
            "biome",
            "clangd",
            "dagger",
            "dockerls",
            "eslint",
            "golangci_lint_ls",
            "gopls",
            "graphql",
            "html",
            "jsonls",
            "lua_ls",
            "ruff",
            "rust_analyzer",
            "sqlls",
            "terraformls",
            "tflint",
            "ts_ls",
            "yamlls",
          },
          max_concurrent_installers = 10,
        })
      end,
    },
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gf", function()
          require("conform").format({ bufnr = ev.buf, async = true, lsp_fallback = true })
        end, opts)
      end,
    })

    vim.diagnostic.config({
      virtual_text = false,
    })

    -- Show line diagnostics automatically in hover window.
    vim.cmd([[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    vim.lsp.enable({
      "bashls",
      "biome",
      "clangd",
      "dagger",
      "dockerls",
      "eslint",
      "golangci_lint_ls",
      "gopls",
      "graphql",
      "html",
      "jsonls",
      "lua_ls",
      "ruff",
      "rust_analyzer",
      "sqlls",
      "terraformls",
      "ts_ls",
      "yamlls",
    })
  end,
}
