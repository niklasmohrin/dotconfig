vim.g.mapleader = " "
vim.g.maplocalleader = "  "

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


vim.api.nvim_create_user_command('PackDel', function()
    vim.pack.del(vim.iter(vim.pack.get())
        :filter(function(x) return not x.active end)
        :map(function(x) return x.spec.name end)
        :totable())
end, {})

require("niklas.general_config")
require("niklas.keybindings")
require("niklas.autocommands")
