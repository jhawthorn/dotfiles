local log = require("overseer.log")

---@param opts overseer.SearchParams
---@return nil|string
local function get_gemfile(opts)
  return vim.fs.find("Gemfile", { upward = true, type = "file", path = opts.dir })[1]
end

local tmpl_update = {
  name = "bundle update",
  priority = 50,
  params = {
    gems = { type = "string", optional = true, order = 1 },
    conservative = { type = "boolean", default = false, optional = true, order = 3 },
    --metadata = { type = "opaque", optional = true },
    --components = { type = "opaque", optional = true },
    --strategy = { type = "opaque", optional = true },
  },
  builder = function(params)
    local cmd = { "bundle", "update", params.gems }
    return {
      cmd = cmd,
      --env = params.env,
      --cwd = params.cwd,
      --name = params.name,
      --metadata = params.metadata,
      --components = params.components,
      --strategy = params.strategy,
    }
  end,
}

local tmpl_install = {
  name = "bundle install",
  priority = 50,
  params = {
    --metadata = { type = "opaque", optional = true },
    --components = { type = "opaque", optional = true },
    --strategy = { type = "opaque", optional = true },
  },
  builder = function(params)
    local cmd = { "bundle", "install" }
    return {
      cmd = cmd,
      --env = params.env,
      --cwd = params.cwd,
      --name = params.name,
      --metadata = params.metadata,
      --components = params.components,
      --strategy = params.strategy,
    }
  end,
}

return {
  generator = function(search, cb)
    cb({ tmpl_update, tmpl_install })
  end,

  condition = {
    callback = function(search)
      return true
    end,
  },
}
