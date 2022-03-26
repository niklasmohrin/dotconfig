vim.o.completeopt = "menuone,noselect"
vim.g.completion_matching_strategy_list = { "exact", "substring", "fuzzy" }

local cmp = require "cmp"
cmp.setup {
    snippet = {
        expand = function(args)
            require "luasnip".lsp_expand(args.body)
        end
    },
    mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.close(),
        ["<c-y>"] = cmp.mapping(
            cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            },
            { "i", "c" }
        ),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'nvim_lsp_documentation' },
      { name = 'nvim_lua' },
      { name = 'calc' },
      { name = 'path' },
      { name = 'luasnip', priority = 42, keyword_pattern = [[^\s*]] },
      { name = 'buffer', keyword_length = 5 },
      { name = 'emoji' },
    },
    view = {
        entries = "native",
    },
    experimental = {
        ghost_text = true,
    },
}
