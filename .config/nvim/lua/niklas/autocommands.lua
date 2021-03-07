vim.cmd [[autocmd Filetype markdown setlocal colorcolumn=80]]
vim.cmd [[autocmd! BufNewFile,BufRead *.vs,*.fs set ft=glsl]]
vim.cmd [[autocmd Filetype htmldjango :syntax sync fromstart]]
vim.cmd [[autocmd Filetype rust autocmd BufWritePost <buffer> :lua require'lsp_extensions'.inlay_hints{ prefix = ' » ', aligned = true }]]
