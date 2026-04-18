vim.pack.add({
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/nvim-treesitter/nvim-treesitter-context",
})

require("nvim-treesitter").install {
    -- Bundled:
    -- "c",
    -- "lua",
    -- "markdown",

    "bash",
    "bibtex",
    "cmake",
    "comment",
    "cpp",
    "css",
    "csv",
    "desktop",
    "diff",
    "dockerfile",
    "fish",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "html",
    "htmldjango",
    "java",
    "javascript",
    "json",
    "json5",
    "kdl",
    "latex",
    "make",
    "nginx",
    "nix",
    "python",
    "rust",
    "scss",
    "sql",
    "ssh_config",
    "toml",
    "typescript",
    "typst",
    "yaml",
    "zig",
}

vim.api.nvim_create_autocmd('FileType', {
    pattern = '*',
    callback = function()
        -- Try to enable highlighting
        pcall(vim.treesitter.start)
    end,
})

require("treesitter-context").setup({ max_lines = 10 })
