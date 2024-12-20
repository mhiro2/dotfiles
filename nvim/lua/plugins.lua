return {
  {
    "numToStr/Comment.nvim",
    opts = {},
  },
  {
    "github/copilot.vim",
    event = "VimEnter",
  },
  {
    "lambdalisue/fern.vim",
    dependencies = {
      "lambdalisue/fern-git-status.vim",
      "lambdalisue/fern-hijack.vim",
      "lambdalisue/fern-renderer-nerdfont.vim",
      "lambdalisue/nerdfont.vim",
    },
    event = "VimEnter",
    config = function()
      vim.g["fern#renderer"] = "nerdfont"
      vim.keymap.set(
        "n",
        "<space>f",
        ":Fern . -drawer -reveal=% -toggle -stay -width=40<CR>",
        { noremap = true, silent = true }
      )
    end,
  },
  {
    "j-hui/fidget.nvim",
    opts = {},
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },
  {
    "smoka7/hop.nvim",
    event = "VimEnter",
    keys = {
      { "w", mode = "n" },
      { "W", mode = "n" },
      { "f", mode = { "n", "x", "o" } },
      { "F", mode = { "n", "x", "o" } },
      { "t", mode = { "n", "x", "o" } },
      { "T", mode = { "n", "x", "o" } },
    },
    config = function()
      local mode = { "n", "x", "o" }
      local hop = require("hop")
      local directions = require("hop.hint").HintDirection

      vim.keymap.set("n", "w", function()
        hop.hint_words({ direction = directions.AFTER_CURSOR })
      end, { remap = true })
      vim.keymap.set("n", "W", function()
        hop.hint_words({ direction = directions.BEFORE_CURSOR })
      end, { remap = true })
      vim.keymap.set(mode, "f", function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
      end, { remap = true })
      vim.keymap.set(mode, "F", function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
      end, { remap = true })
      vim.keymap.set(mode, "t", function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
      end, { remap = true })
      vim.keymap.set(mode, "T", function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
      end, { remap = true })

      require("hop").setup()
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    main = "ibl",
    opts = {},
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    config = function()
      local lualine = require("lualine")

      lualine.setup({
        options = {
          theme = "sonokai",
        },
        sections = {
          lualine_c = {
            {
              "filename",
              symbols = {
                readonly = "",
              },
            },
          },
        },
      })
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },
  {
    "folke/noice.nvim",
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = false,
        },
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered({
            border = "single",
          }),
          documentation = cmp.config.window.bordered({
            border = "single",
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "vsnip" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
        view = {
          entries = {
            name = "custom",
            selection_order = "top_down",
          },
          docs = {
            auto_open = true,
          },
        },
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = {
      {
        "williamboman/mason.nvim",
        config = true,
        build = ":MasonUpdate",
      },
      {
        "williamboman/mason-lspconfig.nvim",
        config = function()
          require("mason-lspconfig").setup({
            automatic_installation = true,
            ensure_installed = {
              "basedpyright",
              "bashls",
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
      {
        "jay-babu/mason-null-ls.nvim",
        dependencies = {
          "nvimtools/none-ls.nvim",
          "nvim-lua/plenary.nvim",
        },
        config = function()
          require("mason-null-ls").setup({
            automatic_installation = true,
            ensure_installed = {
              "goimports",
              "jq",
              "prettier",
              "regols",
              "sqlfluff",
              "stylua",
            },
          })

          local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
          local lsp_formatting = function(bufnr)
            vim.lsp.buf.format({
              filter = function(client)
                return client.name == "null-ls"
              end,
              bufnr = bufnr,
            })
          end

          local null_ls = require("null-ls")
          local utils = require("null-ls.utils")

          null_ls.setup({
            root_dir = utils.root_pattern(".null-ls-root", ".git", "package.json"),
            sources = {
              null_ls.builtins.formatting.goimports,
              null_ls.builtins.formatting.prettier,
              null_ls.builtins.formatting.stylua,
            },
            on_attach = function(client, bufnr)
              if client.supports_method("textDocument/formatting") then
                vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                vim.api.nvim_create_autocmd("BufWritePre", {
                  group = augroup,
                  buffer = bufnr,
                  callback = function()
                    lsp_formatting(bufnr)
                  end,
                })
              end
            end,
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
            vim.lsp.buf.format({ async = true })
          end, opts)
        end,
      })

      vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false })

      -- Show line diagnostics automatically in hover window.
      vim.cmd([[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.basedpyright.setup({
        capabilities = capabilities,
        settings = {
          basedpyright = {
            analysis = {
              -- basedpyright is used only for go-to-definition feature.
              typeCheckingMode = "off",
            },
          },
        },
      })
      lspconfig.bashls.setup({ capabilities = capabilities })
      lspconfig.clangd.setup({ capabilities = capabilities })
      lspconfig.dagger.setup({ capabilities = capabilities })
      lspconfig.dockerls.setup({ capabilities = capabilities })
      lspconfig.eslint.setup({ capabilities = capabilities })
      lspconfig.golangci_lint_ls.setup({ capabilities = capabilities })
      lspconfig.gopls.setup({ capabilities = capabilities })
      lspconfig.graphql.setup({ capabilities = capabilities })
      lspconfig.html.setup({ capabilities = capabilities })
      lspconfig.jsonls.setup({ capabilities = capabilities })
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
      lspconfig.sqlls.setup({ capabilities = capabilities })
      lspconfig.ruff.setup({ capabilities = capabilities })
      lspconfig.rust_analyzer.setup({ capabilities = capabilities })
      lspconfig.terraformls.setup({ capabilities = capabilities })
      lspconfig.ts_ls.setup({ capabilities = capabilities })
      lspconfig.yamlls.setup({ capabilities = capabilities })
    end,
    opts = {
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                reportMissingImports = false,
                typeCheckingMode = "standard",
              },
            },
          },
        },
      },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  {
    "kevinhwang91/nvim-ufo",
    event = "VeryLazy",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    init = function()
      vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      vim.opt.foldcolumn = "1"
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
      vim.opt.foldenable = true
    end,
    config = function()
      require("ufo").setup()
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
    end,
  },
  {
    "sainnhe/sonokai",
    event = "VimEnter",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "VimEnter",
    config = function()
      require("telescope").setup()

      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "zf", builtin.find_files, {})
      vim.keymap.set("n", "zg", builtin.live_grep, {})
      vim.keymap.set("n", "zb", builtin.buffers, {})
    end,
  },
  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
  },
  {
    "t9md/vim-quickhl",
    event = "VimEnter",
    keys = {
      { "qj", "<Plug>(quickhl-manual-this)", mode = { "n", "x" } },
      { "qJ", "<Plug>(quickhl-manual-reset)", mode = { "n", "x" } },
      { "ql", "<Plug>(quickhl-cword-toggle)", mode = "n" },
    },
  },
  {
    "LeafCage/yankround.vim",
    event = "TextYankPost",
    keys = {
      { "p", "<Plug>(yankround-p)", mode = { "n", "x" } },
      { "P", "<Plug>(yankround-P)", mode = { "n", "x" } },
      { "gp", "<Plug>(yankround-gp)", mode = { "n", "x" } },
      { "gP", "<Plug>(yankround-gP)", mode = { "n", "x" } },
      { "<C-p>", "<Plug>(yankround-prev)", mode = "n" },
      { "<C-n>", "<Plug>(yankround-next)", mode = "n" },
    },
  },
}
