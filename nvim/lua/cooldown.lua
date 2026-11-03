-- Hold back plugin updates until commits / tags reach a minimum age.
-- Stopgap until lazy.nvim supports this natively: https://github.com/folke/lazy.nvim/issues/2141
-- Works by wrapping lazy.manage.git; explicit `commit`/`tag`, `pin` and local plugins are untouched.
local M = {}

---@param dir string
---@param args string[]
---@return string?
local function git(dir, args)
  local res = vim.system(vim.list_extend({ "git" }, args), { cwd = dir, text = true }):wait()
  if res.code == 0 then
    return vim.trim(res.stdout)
  end
end

---@param age integer minimum age in seconds
function M.setup(age)
  local Git = require("lazy.manage.git")
  local get_versions = Git.get_versions
  local get_target = Git.get_target

  -- drop tags created within the cooldown window before lazy picks the latest version
  Git.get_versions = function(repo, spec)
    local out = git(repo, { "for-each-ref", "--format=%(refname:short) %(creatordate:unix)", "refs/tags" })
    if not out then
      return get_versions(repo, spec)
    end
    local cutoff = os.time() - age
    local created = {} ---@type table<string, integer>
    for _, line in ipairs(vim.split(out, "\n", { trimempty = true })) do
      local tag, ts = line:match("^(%S+) (%d+)$")
      if tag then
        created[tag] = tonumber(ts)
      end
    end
    return vim.tbl_filter(function(v)
      return (created[v.tag] or 0) <= cutoff
    end, get_versions(repo, spec))
  end

  Git.get_target = function(plugin)
    local target = get_target(plugin)
    if not target or not target.commit or plugin.commit or plugin.tag or plugin._.is_local then
      return target
    end

    -- branch following: latest commit on the branch older than the cutoff
    if not target.tag then
      local eligible =
        git(plugin.dir, { "rev-list", "-1", "--first-parent", "--before=@" .. (os.time() - age), target.commit })
      if not eligible or eligible == "" then
        return target
      end
      target = { branch = target.branch, commit = eligible }
    end

    -- never downgrade a plugin that is already ahead of the eligible commit
    local info = Git.info(plugin.dir)
    if
      info
      and info.commit
      and not Git.eq(info, target)
      and git(plugin.dir, { "merge-base", "--is-ancestor", target.commit, info.commit })
    then
      return { branch = target.branch, commit = info.commit }
    end
    return target
  end
end

return M
