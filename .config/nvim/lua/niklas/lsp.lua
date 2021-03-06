local lspconfig = require "lspconfig"
local completion = require "completion"
local status = require "lsp-status"

status.register_progress()

local on_attach = function(client, bufnr)
    status.on_attach(client, bufnr)
    completion.on_attach(client, bufnr)
    local filetype = vim.api.nvim_buf_get_option(0, 'filetype')

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

    if filetype == "rust" then
        buf_set_keymap('n', '<leader>T', "<cmd>lua require'lsp_extensions'.inlay_hints{ prefix = ' » ', aligned = true }<CR>", opts)
        vim.cmd [[autocmd BufEnter,BufWritePost <buffer> :lua require'lsp_extensions'.inlay_hints{ prefix = ' » ', aligned = true }]]
    end

    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    end
    if client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("v", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
            hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
            hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
            hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
            augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]], false)
    end
end

local servers = { "rust_analyzer", "clangd", "pyls", "html", "cssls", "texlab", "r_language_server", "vimls", "dockerls", "clojure_lsp" }

for _, server in ipairs(servers) do
    lspconfig[server].setup({ on_attach = on_attach })
end

lspconfig["tsserver"].setup {
    cmd = { "tsserver", "--stdio" },
}

local sumneko_root_path = vim.fn.expand("$HOME/Dev/lua-language-server")
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"

lspconfig["sumneko_lua"].setup {
    cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = vim.split(package.path, ";"),
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                },
            },
        },
    },
}

lspconfig["elixirls"].setup {
    cmd = { vim.fn.expand "~/Tools/elixir-ls/language_server.sh" },
}
