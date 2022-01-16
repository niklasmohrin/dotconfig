local map = function(mode, lhs, rhs)
    vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true })
end

local luamap = function(mode, lhs, rhs)
    map(mode, lhs, "<cmd>lua " .. rhs .. "<CR>")
end

local normal_lua_bindings = {
    { "<C-p>", "require('telescope.builtin').find_files()" },
    { "<leader>pg", "require('telescope.builtin').git_files()" },
    { "<leader>ps", "require('telescope.builtin').grep_string({ search = vim.fn.input(\"Grep For > \")})" },
    { "<leader>pw", "require('telescope.builtin').grep_string({ search = vim.fn.expand(\"<cword>\") })" },
    { "<leader>pn", "require('niklas.telescope').edit_neovim()"  },
}

local normal_bindings = {
    { "<leader>dd", "<cmd>call vimspector#Launch()<CR>" },
    { "<leader>dq", "<cmd>call vimspector#Reset()<CR>" },
    { "<leader>dr", "<Plug>VimspectorRestart" },
    { "<leader>dl", "<Plug>VimspectorStepInto" },
    { "<leader>dh", "<Plug>VimspectorStepOut" },
    { "<leader>dj", "<Plug>VimspectorStepOver" },
    { "<leader>dG", "<cmd>call vimspector#Continue()<CR>" },
    { "<leader>drc", "<Plug>VimspectorRunToCursor" },
    { "<leader>dbp", "<Plug>VimspectorToggleBreakpoint" },
    { "<leader>dcbp", "<Plug>VimspectorToggleConditionalBreakpoint" },
}

for _, b in ipairs(normal_bindings) do
    map("n", b[1], b[2])
end

for _, b in ipairs(normal_lua_bindings) do
    luamap("n", b[1], b[2])
end

vim.api.nvim_set_keymap(
    "n",
    "ga",
    [[<Plug>(EasyAlign)]],
    {}
)
vim.api.nvim_set_keymap(
    "x",
    "ga",
    [[<Plug>(EasyAlign)]],
    {}
)
