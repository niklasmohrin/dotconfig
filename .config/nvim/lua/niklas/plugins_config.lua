-- completion
vim.cmd [[set shortmess+=c]]
vim.o.completeopt = "menuone,noinsert,noselect"
vim.g.completion_matching_strategy_list = { "exact", "substring", "fuzzy" }

require "niklas.telescope"
require "niklas.statusline"

-- treesitter
-- require"nvim-treesitter.configs".setup {
--     ensure_installed = { "rust", "clojure", "lua", "html", "javascript", "typescript" },
--     highlight = {
--         enable = true,
--     },
-- }
