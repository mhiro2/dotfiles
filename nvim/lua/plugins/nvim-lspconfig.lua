return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufAdd", "BufNewFile" },
  dependencies = {
    {
      "mason-org/mason.nvim",
      config = true,
      build = ":MasonUpdate",
    },
    "b0o/schemastore.nvim",
    {
      "mason-org/mason-lspconfig.nvim",
      config = function()
        require("mason-lspconfig").setup({
          ensure_installed = {
            "bashls",
            "biome",
            "clangd",
            "dockerls",
            "golangci_lint_ls",
            "gopls",
            "graphql",
            "html",
            "jsonls",
            "lua_ls",
            "oxlint",
            "oxfmt",
            "ruff",
            "rust_analyzer",
            "sqlls",
            "terraformls",
            "tflint",
            "ts_ls",
            "yamlls",
          },
          automatic_enable = false,
        })
      end,
    },
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", function()
          if not require("i18n-status").goto_definition(ev.buf) then
            vim.lsp.buf.definition()
          end
        end, opts)
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

    -- Show line diagnostics automatically in hover window without clearing other autocmds.
    local diag_hover_group = vim.api.nvim_create_augroup("UserLspDiagnosticHover", { clear = true })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = diag_hover_group,
      callback = function()
        vim.diagnostic.open_float(nil, { focus = false })
      end,
    })

    local capabilities = require("blink.cmp").get_lsp_capabilities()

    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    vim.lsp.enable({
      "bashls",
      "biome",
      "clangd",
      "dockerls",
      "golangci_lint_ls",
      "gopls",
      "graphql",
      "html",
      "jsonls",
      "lua_ls",
      "oxlint",
      "ruff",
      "rust_analyzer",
      "sqlls",
      "terraformls",
      "tflint",
      "ts_ls",
      "yamlls",
    })
  end,
}
