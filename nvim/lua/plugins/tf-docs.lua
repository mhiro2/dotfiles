return {
  "mhiro2/tf-docs.nvim",
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
            local tf = require("tf-docs")
            -- resolve() returns (url|nil, trace) without opening anything,
            -- so we can route to LSP hover when there's no docs to open.
            local url = tf.resolve(0)
            if url and url ~= "" then
              tf.open(0)
              return
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
