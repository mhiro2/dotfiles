-- conform.nvim の lsp_format = "fallback" 判定を補正する。

local M = {}

---@param bufnr integer
---@return boolean
local function has_explicit_formatter(bufnr)
  local by_ft = require("conform").formatters_by_ft
  local filetype = vim.bo[bufnr].filetype
  local candidates = { filetype }

  -- conform と同じく複合 filetype ("markdown.mdx" 等) を分解して見る。
  vim.list_extend(candidates, vim.split(filetype, ".", { plain = true }))
  table.insert(candidates, "_")

  for _, name in ipairs(candidates) do
    local formatters = by_ft[name]
    if formatters ~= nil and (type(formatters) == "function" or not vim.tbl_isempty(formatters)) then
      return true
    end
  end
  return false
end

---@param bufnr integer
---@return table
function M.opts(bufnr)
  return {
    timeout_ms = 500,
    -- 明示 formatter があればそれだけ、無ければ trim の後に LSP format を通す。
    lsp_format = has_explicit_formatter(bufnr) and "never" or "last",
  }
end

return M
