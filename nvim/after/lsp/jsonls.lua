local ok, schemastore = pcall(require, "schemastore")
if not ok then
  return {}
end

return {
  settings = {
    json = {
      schemas = schemastore.json.schemas(),
      validate = { enable = true },
    },
  },
}
