-- completion
vim.cmd [[set shortmess+=c]]
vim.cmd [[filetype plugin on]]
vim.g.rooter_patterns = { ".git" }

require "niklas.telescope"
require "niklas.statusline"
