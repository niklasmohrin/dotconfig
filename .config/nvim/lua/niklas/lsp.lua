local lspconfig = require "lspconfig"
local util = require "lspconfig/util"
local status = require "lsp-status"

require "niklas.completion"

status.register_progress()

vim.keymap.set("n", "<leader>K", vim.diagnostic.open_float)

local on_attach = function(client, bufnr)
    local filetype = vim.api.nvim_buf_get_option(0, 'filetype')

    status.on_attach(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local keymap_opts = { silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD',        vim.lsp.buf.declaration, keymap_opts)
    vim.keymap.set('n', 'gd',        vim.lsp.buf.definition, keymap_opts)
    vim.keymap.set('n', 'gi',        lazy_require("telescope.builtin", "lsp_implementations"), keymap_opts)
    vim.keymap.set('n', 'K',         vim.lsp.buf.hover, keymap_opts)
    vim.keymap.set('n', 'gr',        vim.lsp.buf.references, keymap_opts)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, keymap_opts)
    vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, keymap_opts)
    vim.keymap.set('v', '<leader>a', vim.lsp.buf.range_code_action, keymap_opts)

    if filetype == "rust" then
        local do_inlay_hints = lazy_require("lsp_extensions", "inlay_hints", {{ prefix = ' » ', aligned = true }})
        local group = vim.api.nvim_create_augroup("inlay_hints", { clear = true })

        vim.keymap.set('n', '<leader>T', do_inlay_hints, keymap_opts)
        vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost"}, { buffer = bufnr, callback = do_inlay_hints, group = group })
    end

    if client.resolved_capabilities.document_formatting then
        vim.keymap.set("n", "<leader>f", vim.lsp.buf.formatting, keymap_opts)
    end
    if client.resolved_capabilities.document_range_formatting then
        vim.keymap.set("v", "<leader>f", vim.lsp.buf.range_formatting, keymap_opts)
    end
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local servers = { "clangd", "pylsp", "html", "cssls", "texlab", "r_language_server", "vimls", "dockerls", "tsserver", "solargraph", "jsonls", "hls" }

for _, server in ipairs(servers) do
    lspconfig[server].setup({ on_attach = on_attach, capabilities = capabilities })
end

lspconfig["rust_analyzer"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    -- don't use the fancy cargo-metadata stuff right now
    root_pattern = util.root_pattern("rust-project.json", "Cargo.toml"),
}

