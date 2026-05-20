vim.pack.add({
    "https://github.com/nvim-tree/nvim-web-devicons",
})

vim.opt.showmode = false
vim.opt.laststatus = 3
vim.opt.statusline = "%{%v:lua.require'niklas.statusline'.render_status()%}"
vim.opt.winbar = "%{%v:lua.require'niklas.statusline'.render_win()%}"
