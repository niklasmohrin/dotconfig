local group = vim.api.nvim_create_augroup("niklas", { clear = true })
vim.api.nvim_create_autocmd("Filetype", { pattern = "markdown",   command = "setlocal colorcolumn=80", group = group })
vim.api.nvim_create_autocmd("Filetype", { pattern = "htmldjango", command = "syntax sync fromstart", group = group })
vim.api.nvim_create_autocmd("Filetype", { pattern = "c,cpp",      command = "setlocal commentstring=//\\ %s", group = group })
vim.api.nvim_create_autocmd("Filetype", { pattern = "tex",        command = "setlocal textwidth=100", group = group })
vim.api.nvim_create_autocmd("Filetype", {
    pattern = "tex",
    callback = function()
        vim.keymap.set("n", "<leader>b", ":silent :make -s SRC=%<CR>", { buffer = true })
    end,
    group = group
})
vim.api.nvim_create_autocmd("TextYankPost", { callback = vim.highlight.on_yank, group = group })
