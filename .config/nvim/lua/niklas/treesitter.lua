require("nvim-treesitter.configs").setup {
    ensure_installed = "all",
    highlight = { enable = true },
    playground = { enable = true },
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
require("treesitter-context").setup {
    max_lines = 10,
}
