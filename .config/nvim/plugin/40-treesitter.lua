vim.pack.add({
        "https://github.com/nvim-treesitter/nvim-treesitter",
        "https://github.com/nvim-treesitter/nvim-treesitter-context",
    })

--             require("nvim-treesitter.configs").setup ({
--                 ensure_installed = "all",
--                 auto_install = false,
-- 
--                 highlight = { enable = true },
--                 incremental_selection = {
--                     enable = true,
--                     keymaps = {
--                         init_selection = "<leader>gk",
--                         node_incremental = "gk",
--                         scope_incremental = "gh",
--                         node_decremental = "gj",
--                     },
--                 },
--             })
-- 
--         require("treesitter-context").setup( { max_lines = 10 })
