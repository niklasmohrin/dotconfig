return {
    {
        "rmehri01/onenord.nvim",
        commit = "039f76baf948acfc7c7d987ad9392fdc2a0e8a1c",
        lazy = false,
        priority = 1000,
        config = function()
            vim.o.termguicolors = true
            require("onenord").setup()
            -- vim.cmd [[ colorscheme kanagawa ]]
        end
    }
}
