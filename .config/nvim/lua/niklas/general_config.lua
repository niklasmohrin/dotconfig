-- global
vim.o.mouse = "a"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.laststatus = 2
vim.o.wildmenu = true
vim.o.wildmode = "longest,list,full"

-- local to window
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = "yes"
vim.wo.wrap = false
vim.wo.cursorline = true
vim.wo.spell = true
vim.wo.list = true
vim.wo.listchars = "trail:·,tab:>-"

-- local to buffer
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.undofile = true
vim.o.spelllang = "en_us,de_de"
