vim.o.completeopt = "menuone,noinsert,noselect"
vim.g.completion_matching_strategy_list = { "exact", "substring", "fuzzy" }

local lspconfig = require('lspconfig')
local completion = require('completion')
local servers = { 'rust_analyzer', 'clangd', 'pyls', 'tsserver', 'html', 'cssls', 'texlab', 'r_language_server', 'vimls', 'dockerls' }

for _, server in ipairs(servers) do
	lspconfig[server].setup({ on_attach = completion.on_attach })
end

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
