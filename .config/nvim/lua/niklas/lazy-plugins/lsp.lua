return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require "lspconfig"
            local util = require "lspconfig/util"

            local servers_with_default_settings = {
                "cssls",
                "dockerls",
                "html",
                "nil_ls",
                "pylsp",
                "r_language_server",
                "rust_analyzer",
                "sqls",
                "texlab",
                "ts_ls",
            }
            for _, server in ipairs(servers_with_default_settings) do
                lspconfig[server].setup {
                    -- capabilities = capabilities,
                    settings = {
                        ["pylsp"] = {
                            plugins = {
                                pycodestyle = {
                                    maxLineLength = 88, -- same as Black
                                },
                                -- pylint = { enabled = true },
                                black = { enabled = true },
                                yapf = { enabled = false },
                            },
                        },
                        ["nil"] = { formatting = { command = { "nixpkgs-fmt" } } },
                        ["rust-analyzer"] = {
                            server = {
                                extraEnv = {
                                    RUSTFLAGS = vim.env.RUSTFLAGS,
                                    CARGO_TARGET_DIR = vim.env.CARGO_TARGET_DIR,
                                },
                            },
                        },
                    },
                }
            end

            lspconfig.lua_ls.setup {
                on_init = function(client)
                    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                        runtime = { version = "LuaJIT" },
                        workspace = {
                            checkThirdParty = false,
                            library = { vim.env.VIMRUNTIME },
                        },
                    })
                end,
                settings = { Lua = {} },
            }

            lspconfig["clangd"].setup {
                capabilities = capabilities,
                root_dir = util.root_pattern(".git", ".envrc"),
                settings = { ["clangd"] = { semantic_tokens = { enable = false } } },
            }

            lspconfig["tinymist"].setup {
                capabilities = capabilities,
                root_dir = util.root_pattern(".git", "flake.nix"),
                settings = { formatterMode = "typstyle" },
            }

            lspconfig["jsonls"].setup { cmd = { "vscode-json-languageserver", "--stdio" } }

            vim.keymap.set("n", "<leader>K", vim.diagnostic.open_float)

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("niklas_lsp", { clear = true }),
                callback = function(args)
                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    assert(client ~= nil)

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
        end
    },
    {
        "nvim-lua/lsp-status.nvim",
        config = function()
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
        end
    },

    {
        "Julian/lean.nvim",
        ft = "lean",
        opts = {
            mappings = true,
            -- lsp = { root_dir = util.root_pattern("lean-toolchain", "flake.nix", ".git") },
        }
    },
    -- { "kaarmu/typst.vim", ft = "typst" },
}
