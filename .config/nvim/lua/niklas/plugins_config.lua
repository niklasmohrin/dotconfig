vim.cmd [[set shortmess+=c]]

local telescope = require "telescope"

telescope.setup {
	defaults = {
		file_sorter = require('telescope.sorters').get_fzy_sorter,
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
	},
}

telescope.load_extension "fzy_native"
