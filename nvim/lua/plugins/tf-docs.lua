return {
  "mhiro2/tf-docs.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  ft = { "terraform", "hcl" },
  config = function()
    require("tf-docs").setup()
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local buf = args.buf
        local ft = vim.bo[buf].filetype
        if ft ~= "terraform" and ft ~= "hcl" then
          return
        end

        -- Ensure we run after other attach handlers
        vim.schedule(function()
          vim.keymap.set("n", "K", function()
            local ok_resolver, resolver = pcall(require, "tf-docs.resolver")
            local ok_ui, ui = pcall(require, "tf-docs.ui")
            if ok_resolver and ok_ui then
              local ok, url = pcall(function()
                local u = resolver.resolve(0) -- url|nil, trace
                return u
              end)
              if ok and url and url ~= "" then
                ui.open(url)
                return
              end
            end
            if vim.lsp and vim.lsp.buf and vim.lsp.buf.hover then
              vim.lsp.buf.hover()
            end
          end, { buffer = buf, desc = "Terraform: docs or hover" })
        end)
      end,
    })
  end,
}
