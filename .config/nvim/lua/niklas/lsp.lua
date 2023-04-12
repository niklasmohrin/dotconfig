local lspconfig = require "lspconfig"
local util = require "lspconfig/util"
local status = require "lsp-status"
local inlay_hints = require "lsp-inlayhints"

require "niklas.completion"

status.config { diagnostics = false, status_symbol = "" }
status.register_progress()
inlay_hints.setup {
    inlay_hints = {
        highlight = "Comment",
    },
}
require("lsp-inlayhints.adapter").set_old_tsserver()

vim.keymap.set("n", "<leader>K", vim.diagnostic.open_float)

local on_attach = function(client, bufnr)
    -- Disable semantic highlighting
    client.server_capabilities.semanticTokensProvider = nil

    status.on_attach(client, bufnr)
    -- inlay_hints.on_attach(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    local keymap_opts = { silent = true, buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, keymap_opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)
    vim.keymap.set("n", "gi", lazy_require("telescope.builtin", "lsp_implementations"), keymap_opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, keymap_opts)
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, keymap_opts)
    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, keymap_opts)
    vim.keymap.set("v", "<leader>a", vim.lsp.buf.range_code_action, keymap_opts)
    vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format {
            async = true,
            filter = function(client)
                return client.name ~= "tsserver"
            end,
        }
    end, keymap_opts)
    vim.keymap.set("v", "<leader>f", vim.lsp.buf.range_formatting, keymap_opts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers_with_default_settings = {
    "clangd",
    "cssls",
    "dockerls",
    "hls",
    "html",
    "jdtls",
    "jsonls",
    "r_language_server",
    "rust_analyzer",
    "solargraph",
    "texlab",
    "vimls",
}

for _, server in ipairs(servers_with_default_settings) do
    lspconfig[server].setup { on_attach = on_attach, capabilities = capabilities }
end

tsserver_inlay_hints_settings = {
    includeInlayParameterNameHints = "all",
    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
    includeInlayFunctionParameterTypeHints = true,
    includeInlayVariableTypeHints = true,
    includeInlayPropertyDeclarationTypeHints = true,
    includeInlayFunctionLikeReturnTypeHints = true,
    includeInlayEnumMemberValueHints = true,
}
lspconfig["tsserver"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        typescript = { inlayHints = tsserver_inlay_hints_settings },
        javascript = { inlayHints = tsserver_inlay_hints_settings },
    },
}

lspconfig["pylsp"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    maxLineLength = 88, -- same as Black
                },
                -- pylint = { enabled = true },
                black = { enabled = true },
                yapf = { enabled = false },
            },
        },
    },
}

lspconfig["emmet_ls"].setup {
    cmd = { "node", "/home/niklas/Tools/emmet-ls/out/server.js", "--stdio" },
    capabilities = capabilities,
    filetypes = {
        "html",
        "css",
        "htmldjango",
    },
    settings = {
        html_filetypes = { "html", "htmldjango" },
        css_filetypes = { "html", "htmldjango", "css" },
    },
}

local null_ls = require "null-ls"
null_ls.setup {
    on_attach = on_attach,
    sources = {
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.formatting.stylua,
    },
}
