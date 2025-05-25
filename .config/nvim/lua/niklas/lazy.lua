local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    return
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { "folke/lazy.nvim", commit = "1c9ba3704564a2e34a22191bb89678680ffeb245" },
        { import = "niklas/lazy-plugins" },
    },
    rocks = { enabled = false },
})
