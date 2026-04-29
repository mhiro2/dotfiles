local ok, schemastore = pcall(require, "schemastore")
if not ok then
  return {}
end

return {
  settings = {
    yaml = {
      schemaStore = { enable = false, url = "" },
      schemas = schemastore.yaml.schemas(),
      validate = true,
    },
  },
}
