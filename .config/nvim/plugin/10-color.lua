vim.pack.add({ {
    src = "https://github.com/rmehri01/onenord.nvim",
    version = "039f76baf948acfc7c7d987ad9392fdc2a0e8a1c",
} })

vim.o.termguicolors = true
require("onenord").setup()
-- vim.cmd [[ colorscheme kanagawa ]]
