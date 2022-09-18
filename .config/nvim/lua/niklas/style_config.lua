vim.o.termguicolors = true
-- vim.cmd [[let ayucolor="mirage"]]
-- vim.cmd [[colorscheme ayu]]

require("onenord").setup()

-- local parser_configs = require"nvim-treesitter.parsers".get_parser_configs()

-- parser_configs.django = {
--     install_info = {
--         url = "~/Dev/tree-sitter-django",
--         files = { "src/parser.c" },
--     },
--     filetype = "htmldjango",
-- }
-- parser_configs["embedded-template"] = {
--     install_info = {
--         url = "https://github.com/tree-sitter/tree-sitter-embedded-template",
--         files = { "src/parser.c" },
--     },
--     filetype = "ejs",
-- }

require("nvim-treesitter.configs").setup {
    ensure_installed = "all",
    highlight = {
        enable = true,
        -- to get rid of the random underlines in code; it has something to with `set spell`
        -- additional_vim_regex_highlighting = true,
    },
    playground = {
        enable = true,
    },
}
