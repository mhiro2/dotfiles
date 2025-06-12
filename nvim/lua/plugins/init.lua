local plugins = {}

-- Auto-detect plugin files in the plugins directory
local plugins_dir = vim.fn.stdpath("config") .. "/lua/plugins"
local plugin_files = {}

-- Get all .lua files in plugins directory except init.lua
local handle = vim.loop.fs_scandir(plugins_dir)
if handle then
  while true do
    local name, type = vim.loop.fs_scandir_next(handle)
    if not name then
      break
    end

    if type == "file" and name:match("%.lua$") and name ~= "init.lua" then
      local plugin_name = name:gsub("%.lua$", "")
      table.insert(plugin_files, plugin_name)
    end
  end
end

-- Sort for consistent loading order
table.sort(plugin_files)

-- Load all detected plugin files
for _, plugin_file in ipairs(plugin_files) do
  local ok, plugin_config = pcall(require, "plugins." .. plugin_file)
  if ok then
    table.insert(plugins, plugin_config)
  else
    vim.notify("Failed to load plugin: " .. plugin_file, vim.log.levels.WARN)
  end
end

return plugins
