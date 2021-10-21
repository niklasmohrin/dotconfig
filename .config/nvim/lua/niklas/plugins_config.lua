-- completion
vim.cmd [[set shortmess+=c]]
vim.cmd [[filetype plugin on]]
vim.g.rooter_patterns = { ".git" }
-- require("project_nvim").setup {
--     patterns = { ".git", "package.json" },
--     ignore_lsp = { "pylsp" },
--     silent_chdir = false,
-- }

require "niklas.telescope"
require "niklas.statusline"
