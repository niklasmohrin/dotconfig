local lspconfig = require "lspconfig"
local util = require "lspconfig/util"
local status = require "lsp-status"

vim.o.completeopt = "menuone,noselect"
vim.g.completion_matching_strategy_list = { "exact", "substring", "fuzzy" }
require "niklas.completion"

status.register_progress()

local on_attach = function(client, bufnr)
    status.on_attach(client, bufnr)
    local filetype = vim.api.nvim_buf_get_option(0, 'filetype')

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gi', '<Cmd>lua require"telescope.builtin".lsp_implementations()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('v', '<leader>a', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)

    if filetype == "rust" then
        buf_set_keymap('n', '<leader>T', "<cmd>lua require'lsp_extensions'.inlay_hints{ prefix = ' » ', aligned = true }<CR>", opts)
        vim.cmd [[autocmd BufEnter,BufWritePost <buffer> :lua require'lsp_extensions'.inlay_hints{ prefix = ' » ', aligned = true }]]
    end

    if filetype == "python" then
        buf_set_keymap("n", "<leader>f", "<cmd>Black<CR>", opts)
    else
        if client.resolved_capabilities.document_formatting then
            buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
        end
        if client.resolved_capabilities.document_range_formatting then
            buf_set_keymap("v", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
        end
    end

    -- if client.resolved_capabilities.document_highlight then
    --     vim.api.nvim_exec([[
    --         hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
    --         hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
    --         hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
    --         augroup lsp_document_highlight
    --         autocmd! * <buffer>
    --         autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    --         autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    --         augroup END
    --     ]], false)
    -- end
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

-- local sumneko_root_path = vim.fn.expand("$HOME/Dev/lua-language-server")
-- local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"

-- lspconfig["sumneko_lua"].setup {
--     cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
--     settings = {
--         Lua = {
--             runtime = {
--                 version = "LuaJIT",
--                 path = vim.split(package.path, ";"),
--             },
--             diagnostics = {
--                 globals = { "vim" },
--             },
--             workspace = {
--                 library = {
--                     [vim.fn.expand("$VIMRUNTIME/lua")] = true,
--                     [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
--                 },
--             },
--         },
--     },
-- }

-- lspconfig["elixirls"].setup {
--     cmd = { vim.fn.expand "~/Tools/elixir-ls/language_server.sh" },
-- }

------------------------------

--local dap = require('dap')
--dap.adapters.lldb = {
--  type = 'executable',
--  command = '/bin/lldb-vscode',
--  name = "lldb"
--}
--dap.configurations.rust = {
--  {
--    name = "Launch",
--    type = "lldb",
--    request = "launch",
--    program = function()
--      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--    end,
--    cwd = '${workspaceFolder}',
--    stopOnEntry = false,
--    args = {},

--    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
--    --
--    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
--    --
--    -- Otherwise you might get the following error:
--    --
--    --    Error on launch: Failed to attach to the target process
--    --
--    -- But you should be aware of the implications:
--    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
--    runInTerminal = false,
--  },
--}

---- from :h dap-mappings
--vim.cmd [[
--    nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
--    nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
--    nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
--    nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
--    nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
--    nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
--    nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
--    nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
--    nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>
--]]
