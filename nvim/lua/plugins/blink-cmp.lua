return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  version = "1.*",
  opts = {
    keymap = {
      preset = "none",
      ["<CR>"] = { "select_and_accept", "fallback" },
      ["<C-Space>"] = { "show", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<Tab>"] = { "show_and_insert_or_accept_single", "select_and_accept" },
      ["<S-Tab>"] = false,
    },
    sources = {
      default = { "lsp", "path", "buffer" },
    },
    completion = {
      accept = {
        auto_brackets = { enabled = true },
      },
      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },
      documentation = {
        auto_show = true,
        window = { border = "single" },
      },
      menu = { border = "single" },
      ghost_text = { enabled = true },
    },
    cmdline = {
      keymap = {
        preset = "inherit",
        ["<CR>"] = { "fallback" },
      },
      sources = function()
        local cmdtype = vim.fn.getcmdtype()
        if cmdtype == "/" or cmdtype == "?" then
          return { "buffer" }
        end
        if cmdtype == ":" or cmdtype == "@" then
          return { "path", "cmdline" }
        end
        return {}
      end,
      completion = {
        menu = { auto_show = true },
        list = {
          selection = {
            preselect = false,
            auto_insert = false,
          },
        },
        ghost_text = { enabled = true },
      },
    },
  },
  config = function(_, opts)
    require("blink.cmp").setup(opts)
  end,
}
