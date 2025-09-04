return {
    {
        "nvim-telescope/telescope.nvim",
        -- TODO: continue at actions/layout.lua
        commit = "a0bbec21143c7bc5f8bb02e0005fa0b982edc026",
        branch = "0.1.x",
        dependencies = {
            { "nvim-lua/plenary.nvim", commit = "857c5ac632080dba10aae49dba902ce3abf91b35" },
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local telescope = require "telescope"
            local telescopeConfig = require "telescope.config"

            local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
            table.insert(vimgrep_arguments, "--hidden")
            table.insert(vimgrep_arguments, "--glob")
            table.insert(vimgrep_arguments, "!**/.git/*")

            telescope.setup {
                defaults = { vimgrep_arguments = vimgrep_arguments },
                pickers = { find_files = { find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" } } },
            }

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
        end
    },
}
