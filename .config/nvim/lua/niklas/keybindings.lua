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

-- compe
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  -- elseif vim.fn['vsnip#available'](1) == 1 then
  --   return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  -- elseif vim.fn['vsnip#jumpable'](-1) == 1 then
  --   return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<c-space>", "compe#complete()", { silent = true, noremap = true, expr = true })
vim.api.nvim_set_keymap("i", "<CR>", 'compe#confirm("<CR>")', { silent = true, noremap = true, expr = true })
vim.api.nvim_set_keymap("i", "<c-e>", 'compe#close("<c-e>")', { silent = true, noremap = true, expr = true })

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })

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
