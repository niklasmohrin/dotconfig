return {
    {
        "airblade/vim-rooter",
        commit = "51402fb77c4d6ae94994e37dc7ca13bec8f4afcc",
        config = function()
            vim.g.rooter_patterns = { "!.vim-rooter-ignore", ".git", ".vim-rooter" }
        end,
    },
    {
        "alvan/vim-closetag",
        commit = "d0a562f8bdb107a50595aefe53b1a690460c3822",
        config = function()
            vim.cmd [[let g:closetag_filetypes = 'html,xhtml,eruby']]
        end,
    },

    -- Maybe not needed with Neovim 0.10?
    -- { "numToStr/Comment.nvim", opts = {} },

    { "junegunn/vim-easy-align", commit = "9815a55dbcd817784458df7a18acacc6f82b1241" },

    { "tpope/vim-fugitive",      commit = "4a745ea72fa93bb15dd077109afbb3d1809383f2" },

    { "lewis6991/gitsigns.nvim", commit = "02eafb1273afec94447f66d1a43fc5e477c2ab8a", opts = {} },

    -- "L3MON4D3/LuaSnip",

    -- {
    --     "dstein64/vim-startuptime",
    --     cmd = "StartupTime",
    -- },
}
