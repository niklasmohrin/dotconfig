local map = function(mode, lhs, rhs)
	vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true })
end

local luamap = function(mode, lhs, rhs)
	map(mode, lhs, "<cmd>lua " .. rhs .. "<CR>")
end

local normal_bindings = {
	{ "<C-p>", "require('telescope.builtin').git_files()" },
	{ "<leader>pf", "require('telescope.builtin').find_files()" },
	{ "<leader>ps", "require('telescope.builtin').grep_string({ search = vim.fn.input(\"Grep For > \")})" },
	{ "<leader>pw", "require('telescope.builtin').grep_string({ search = vim.fn.expand(\"<cword>\") })" },
	{ "gd", "vim.lsp.buf.definition()" },
	{ "K", "vim.lsp.buf.hover()" },
	{ "gr", "vim.lsp.buf.references()" },
	{ "<leader>r", "vim.lsp.buf.rename()" },
	{ "<leader>f", "vim.lsp.buf.formatting()" },
	{ "<leader>T", "require'lsp_extensions'.inlay_hints{ prefix = ' » ', aligned = true }" },
}

map(
	"i",
	"<expr> <Tab>",
	"pumvisible() ? '\\<C-n>' : '\\<Tab>'"
)
map(
	"i",
	"<expr> <S-Tab>",
	"pumvisible() ? '\\<C-p>' : '\\<S-Tab>'"
)

for _, b in ipairs(normal_bindings) do
	luamap("n", b[1], b[2])
end
