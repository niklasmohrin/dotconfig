local map = function(mode, lhs, rhs)
    vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true })
end

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
    -- quickfixlist
    { "<C-j>", "<Cmd>cnext<CR>" },
    { "<C-k>", "<Cmd>cprev<CR>" },
}

for _, b in ipairs(normal_bindings) do
    map("n", b[1], b[2])
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

-- https://vim.fandom.com/wiki/Mouse_wheel_for_scroll_only_-_disable_middle_button_paste
for _, prefix in ipairs({"", "2-", "3-", "4-"}) do
    local event = string.format("<%sMiddleMouse>", prefix)
    vim.api.nvim_set_keymap("", event, "<Nop>", {})
    vim.api.nvim_set_keymap("i", event, "<Nop>", {})
end
