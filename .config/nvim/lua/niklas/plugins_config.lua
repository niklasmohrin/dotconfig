-- completion
vim.cmd [[set shortmess+=c]]
vim.o.completeopt = "menuone,noinsert,noselect"
vim.g.completion_matching_strategy_list = { "exact", "substring", "fuzzy" }

-- telescope
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

-- treesitter
-- require"nvim-treesitter.configs".setup {
--     ensure_installed = "rust",
--     highlight = {
--         enable = true,
--     },
-- }
