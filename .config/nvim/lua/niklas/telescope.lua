local telescope = require "telescope"

telescope.setup {
    extensions = {
        ["zf-native"] = {
            file = {
                enable = true,
                highlight_results = true,
                match_filename = true,
            },
            generic = {
                enable = true,
                highlight_results = true,
                match_filename = false,
            },
        },
    },
}
telescope.load_extension "zf-native"
-- telescope.load_extension "fzy_native"

local function edit_config()
    require("telescope.builtin").git_files {
        prompt_title = "Neovim dotfiles",
        shorten_path = false,
        cwd = "~/dotconfig/",
    }
end

vim.keymap.set("n", "<C-p>", function()
    require("telescope.builtin").find_files { hidden = true }
end)
vim.keymap.set("n", "<leader>pg", function()
    require("telescope.builtin").git_files()
end)
vim.keymap.set("n", "<leader>ps", function()
    require("telescope.builtin").live_grep()
end)
vim.keymap.set("n", "<leader>pw", function()
    require("telescope.builtin").grep_string()
end)
vim.keymap.set("n", "<leader>pm", function()
    require("telescope.builtin").man_pages()
end)
vim.keymap.set("n", "<leader>pn", edit_config)
