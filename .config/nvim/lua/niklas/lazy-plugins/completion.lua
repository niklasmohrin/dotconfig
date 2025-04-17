return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-calc",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-emoji",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp",

            "L3MON4D3/LuaSnip",
        },

        config = function()
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
                    { name = 'nvim_lua' },
                    { name = 'calc' },
                    { name = 'path' },
                    { name = 'luasnip', priority = 42,     keyword_pattern = [[^\s*]] },
                    { name = 'buffer',  keyword_length = 5 },
                    { name = 'emoji' },
                },
                view = {
                    entries = "native",
                },
                experimental = {
                    ghost_text = true,
                },
            }
        end,
    }
}
