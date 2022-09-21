vim.g.mapleader = " "

P = function(v)
  print(vim.inspect(v))
  return v
end

RELOAD = function(...)
  return require("plenary.reload").reload_module(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end

lazy_require = function(module, fn_name, args)
    args = args or {}
    return function()
        -- Note: In Lua 5.2, unpack is moved to table.unpack
        return require(module)[fn_name](unpack(args))
    end
end

require("niklas.plugins")
require("niklas.general_config")
require("niklas.plugins_config")
require("niklas.lsp")
require("niklas.keybindings")
require("niklas.autocommands")
require("niklas.colors")
require("niklas.treesitter")
require("niklas.statusline")
