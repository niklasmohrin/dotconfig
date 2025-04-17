return {
    {
        "airblade/vim-rooter",
        config = function()
            vim.g.rooter_patterns = { "!.vim-rooter-ignore", ".git", ".vim-rooter" }
        end,
    },
    {
        "alvan/vim-closetag",
        config = function()
            vim.cmd [[let g:closetag_filetypes = 'html,xhtml,eruby']]
        end,
    },

    -- Maybe not needed with Neovim 0.10?
    -- { "numToStr/Comment.nvim", opts = {} },

    "junegunn/vim-easy-align",

    "tpope/vim-fugitive",
    "lewis6991/gitsigns.nvim",

    -- "L3MON4D3/LuaSnip",

    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
    },
}
