vim.pack.add({
    {
        src = "https://github.com/airblade/vim-rooter",
        version = "51402fb77c4d6ae94994e37dc7ca13bec8f4afcc",
    },
    {
        src = "https://github.com/alvan/vim-closetag",
        version = "d0a562f8bdb107a50595aefe53b1a690460c3822",
    },

    { src = "https://github.com/junegunn/vim-easy-align", version = "9815a55dbcd817784458df7a18acacc6f82b1241" },

    { src = "https://github.com/tpope/vim-fugitive",      version = "4a745ea72fa93bb15dd077109afbb3d1809383f2" },

    { src = "https://github.com/lewis6991/gitsigns.nvim", version = "02eafb1273afec94447f66d1a43fc5e477c2ab8a" },
})

vim.g.rooter_patterns = { "!.vim-rooter-ignore", ".git", ".vim-rooter" }
vim.cmd [[let g:closetag_filetypes = 'html,xhtml,eruby']]
require("gitsigns").setup({})
