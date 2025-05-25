return {
    {
        "rmehri01/onenord.nvim",
        commit = "039f76baf948acfc7c7d987ad9392fdc2a0e8a1c",
        lazy = false,
        priority = 1000,
        config = function()
            vim.o.termguicolors = true

            local augroup = vim.api.nvim_create_augroup("niklas_colors", { clear = true })
            vim.api.nvim_create_autocmd("Colorscheme", {
                callback = function()
                    local hl = vim.api.nvim_get_hl_by_name("SpellBad", true)
                    hl.italic = false
                    hl.underline = false
                    hl.undercurl = true
                    vim.api.nvim_set_hl(0, "SpellBad", hl)
                end,
                group = augroup,
            })

            require("onenord").setup()
            -- vim.cmd [[ colorscheme kanagawa ]]
        end
    }
}
