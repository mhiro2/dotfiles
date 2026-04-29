return {
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local start = vim.fs.dirname(fname ~= "" and fname or vim.uv.cwd())

    local biome = vim.fs.find({ "biome.json", "biome.jsonc" }, {
      path = start,
      upward = true,
      stop = vim.uv.os_homedir(),
    })
    if #biome > 0 then
      return
    end

    local root = vim.fs.find({ ".oxlintrc.json", "package.json", ".git" }, {
      path = start,
      upward = true,
      stop = vim.uv.os_homedir(),
    })[1]
    if root then
      on_dir(vim.fs.dirname(root))
    end
  end,
}
