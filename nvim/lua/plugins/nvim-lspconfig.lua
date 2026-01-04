return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufAdd", "BufNewFile" },
  dependencies = {
    {
      "mason-org/mason.nvim",
      config = true,
      build = ":MasonUpdate",
    },
    "folke/neodev.nvim",
    {
      "mason-org/mason-lspconfig.nvim",
      config = function()
        require("mason-lspconfig").setup({
          ensure_installed = {
            "bashls",
            "biome",
            "cue",
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
            "sqruff",
            "sqlls",
            "terraformls",
            "tflint",
            "ts_ls",
            "yamlls",
          },
        })
      end,
    },
  },
  config = function()
    local ok, neodev = pcall(require, "neodev")
    if ok then
      neodev.setup()
    end

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
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
            library = vim.api.nvim_get_runtime_file("", true),
          },
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
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
