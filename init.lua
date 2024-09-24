require("core.init")

local lazy = {}

function lazy.install(path)
  if not vim.loop.fs_stat(path) then
    print('Installing lazy.nvim....')
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      path,
    })
  end
end

function lazy.setup(plugins)
  if vim.g.plugins_ready then
    return
  end

  -- You can "comment out" the line below after lazy.nvim is installed
  lazy.install(lazy.path)

  vim.opt.rtp:prepend(lazy.path)

  require('lazy').setup(plugins, lazy.opts)
  vim.g.plugins_ready = true
end


local function collect_plugins(directory)
    local lua_file_paths = {}
    local base_path = vim.fn.stdpath('config') .. '/lua/'
    local path = base_path .. directory

    for _, entry in ipairs(vim.fn.readdir(path)) do
        local full_path = path .. '/' .. entry
        if vim.fn.isdirectory(full_path) == 1 then
            -- Recursively collect Lua files from subdirectories
            for _, subpath in ipairs(collect_plugins(directory .. '/' .. entry)) do
                table.insert(lua_file_paths, subpath)
            end
        else
	     if entry:match("%.lua$") then
                local module_path = full_path:sub(#base_path + 1, -5) -- Remove base path and '.lua'
                module_path = module_path:gsub("/", ".") -- Convert path separators to dots
                table.insert(lua_file_paths, module_path)
            end
        end
    end

    return lua_file_paths
end

local lua_files = collect_plugins('plugins')
local plugins = {}
for _, module_path in ipairs(lua_files) do
    local plugin_config = require(module_path)
    if type(plugin_config) == "table" then
        for _, config in ipairs(plugin_config) do
            table.insert(plugins, config)
        end
    else
        print("Warning: No valid table returned from", module_path)
    end
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}
lazy.setup(plugins)

require("core.ui")
