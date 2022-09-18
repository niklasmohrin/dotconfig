vim.cmd [[set shortmess+=c]]
vim.cmd [[filetype plugin on]]
vim.g.rooter_patterns = { ".git", ".vim-rooter" }

vim.cmd [[let g:closetag_filetypes = 'html,xhtml,eruby']]

require "niklas.telescope"

require("Comment").setup()
