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
        -- ["<c-space>"] = cmp.mapping {
        --     i = cmp.mapping.complete(),
        --     c = function(
        --         _ --[[fallback]]
        --         )
        --         if cmp.visible() then
        --             if not cmp.confirm { select = true } then
        --                 return
        --             end
        --         else
        --             cmp.complete()
        --         end
        --     end,
        -- },
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
    experimental = {
        native_menu = true,
        ghost_text = true,
    },
}
