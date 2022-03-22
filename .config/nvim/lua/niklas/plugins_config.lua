-- completion
vim.cmd [[set shortmess+=c]]
vim.cmd [[filetype plugin on]]
vim.g.rooter_patterns = { ".git", ".vim-rooter" }
-- require("project_nvim").setup {
--     patterns = { ".git", "package.json" },
--     ignore_lsp = { "pylsp" },
--     silent_chdir = false,
-- }

vim.cmd [[let g:closetag_filetypes = 'html,xhtml,eruby']]

require "niklas.telescope"
require "niklas.statusline"

require("Comment").setup()
