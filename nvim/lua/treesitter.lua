vim.treesitter.language.register("bash", { "sh", "zsh" })
vim.treesitter.language.register("tsx", { "javascriptreact", "typescriptreact" })
vim.treesitter.language.register("terraform", { "hcl", "terraform-vars" })

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
