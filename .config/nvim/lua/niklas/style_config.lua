vim.o.termguicolors = true
-- require("colorbuddy").colorscheme("gruvbuddy")
-- vim.cmd [[let ayucolor="mirage"]]
vim.cmd [[colorscheme ayu]]
-- vim.cmd [[highlight Normal guibg=NONE ctermbg=NONE]]

-- treesitter
-- vim.treesitter.set_query("rust", "highlights", read_query "~/.config/nvim/queries/rust/highlights.scm")

local parser_configs = require"nvim-treesitter.parsers".get_parser_configs()

parser_configs.django = {
    install_info = {
        url = "~/Dev/tree-sitter-django",
        files = { "src/parser.c" },
    },
    filetype = "htmldjango",
}
-- parser_configs["embedded-template"] = {
--     install_info = {
--         url = "https://github.com/tree-sitter/tree-sitter-embedded-template",
--         files = { "src/parser.c" },
--     },
--     filetype = "ejs",
-- }

vim.cmd [[syntax enable]]
require"nvim-treesitter.configs".setup {
    ensure_installed = "maintained",
    highlight = {
        enable = true,
        -- to get rid of the random underlines in code; it has something to with `set spell`
        additional_vim_regex_highlighting = true,
    },
    playground = {
        enable = true,
    },
}

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics,
--   { underline = false }
-- )
