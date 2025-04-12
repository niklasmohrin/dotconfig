return {
    {
        "nvim-treesitter/nvim-treesitter",
        -- build = function()
        --     vim.cmd [[TSUpdate]]
        -- end,
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = "all",
                auto_install = false,

                highlight = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<leader>gk",
                        node_incremental = "gk",
                        scope_incremental = "gh",
                        node_decremental = "gj",
                    },
                },
            }
        end
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = { max_lines = 10 },
    },
}
