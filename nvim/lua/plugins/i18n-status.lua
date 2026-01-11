return {
  "mhiro2/i18n-status.nvim",
  config = function()
    require("i18n-status").setup({
      primary_lang = "ja",

      inline = {
        position = "after_key",
      },

      vim.keymap.set("n", "<Space>in", "<Cmd>I18nLangNext<CR>", { desc = "Next language" }),
      vim.keymap.set("n", "<Space>ip", "<Cmd>I18nLangPrev<CR>", { desc = "Previous language" }),
      vim.keymap.set("n", "<Space>id", "<Cmd>I18nDoctor<CR>", { desc = "i18n doctor" }),
      vim.keymap.set("n", "<Space>ia", "<Cmd>I18nAddKey<CR>", { desc = "Add new i18n key" }),
    })
  end,
}
