vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/nvim-lua/lsp-status.nvim",
})

vim.lsp.enable {
    "clangd",
    "cssls",
    "html",
    "lua_ls",
    "nil_ls",
    "pylsp",
    "rust_analyzer",
    "texlab",
    "tinymist",
    "ts_ls",
    "zls",
}

vim.o.completeopt = "menuone,noselect,popup"
vim.g.completion_matching_strategy_list = { "exact", "substring", "fuzzy" }

vim.keymap.set("n", "<leader>K", vim.diagnostic.open_float)

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("niklas_lsp", { clear = true }),
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        assert(client ~= nil)

        vim.lsp.completion.enable(true, client.id, bufnr, {
            autotrigger = true,
        })

        -- Disable semantic highlighting
        client.server_capabilities.semanticTokensProvider = nil

        if client.server_capabilities.completionProvider then
            vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
        end
        if client.server_capabilities.definitionProvider then
            vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
        end

        local keymap_opts = { silent = true, buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, keymap_opts)
        vim.keymap.set("n", "gi", lazy_require("telescope.builtin", "lsp_implementations"), keymap_opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, keymap_opts)
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, keymap_opts)
        vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, keymap_opts)
        vim.keymap.set({ "n", "v" }, "<leader>f", function()
            vim.lsp.buf.format { async = true }
        end, keymap_opts)
    end,
})

local status = require "lsp-status"
status.config { diagnostics = false, status_symbol = "" }
status.register_progress()

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("niklas-lsp-status", { clear = true }),
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        assert(client ~= nil)
        status.on_attach(client, bufnr)
    end,
})
