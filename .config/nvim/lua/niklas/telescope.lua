local telescope = require "telescope"
local telescopeConfig = require "telescope.config"

local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
table.insert(vimgrep_arguments, "--hidden")
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

telescope.setup {
    defaults = { vimgrep_arguments = vimgrep_arguments },
    pickers = { find_files = { find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" } } },
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

local function edit_config()
    require("telescope.builtin").git_files {
        prompt_title = "Dotfiles",
        shorten_path = false,
        cwd = "~/dotconfig/",
    }
end

vim.keymap.set("n", "<C-p>", require("telescope.builtin").find_files)
vim.keymap.set("n", "<leader>pg", require("telescope.builtin").git_files)
vim.keymap.set("n", "<leader>ps", require("telescope.builtin").live_grep)
vim.keymap.set("n", "<leader>pw", require("telescope.builtin").grep_string)
vim.keymap.set("n", "<leader>pm", require("telescope.builtin").man_pages)
vim.keymap.set("n", "<leader>pn", edit_config)
