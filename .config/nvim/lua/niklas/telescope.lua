local telescope = require "telescope"
local telescope_builtin = require "telescope.builtin"
local telescope_sorters = require "telescope.sorters"

telescope.setup {
    defaults = {
        file_sorter = telescope_sorters.get_fzy_sorter,
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
    },
}

telescope.load_extension "fzy_native"

return {
    edit_neovim = function()
        telescope_builtin.find_files {
            prompt_title = "Neovim dotfiles",
            shorten_path = false,
            cwd = "~/.config/nvim",
        }
    end,
}
