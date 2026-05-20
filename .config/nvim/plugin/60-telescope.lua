-- vim.pack.add({
--     {
--         src = "https://github.com/nvim-telescope/telescope.nvim",
--         version = vim.version.range("0.2.x"),
--     },
--     "https://github.com/nvim-lua/plenary.nvim",
--     "https://github.com/nvim-tree/nvim-web-devicons",
-- })

-- local telescope = require "telescope"
-- local telescopeConfig = require "telescope.config"
--
-- local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
-- table.insert(vimgrep_arguments, "--hidden")
-- table.insert(vimgrep_arguments, "--glob")
-- table.insert(vimgrep_arguments, "!**/.git/*")
--
-- telescope.setup {
--     defaults = { vimgrep_arguments = vimgrep_arguments },
--     pickers = { find_files = { find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" } } },
-- }
--
-- local function edit_config()
--     require("telescope.builtin").git_files {
--         prompt_title = "Dotfiles",
--         shorten_path = false,
--         cwd = "~/dotconfig/",
--     }
-- end
--
-- vim.keymap.set("n", "<C-p>", require("telescope.builtin").find_files)
-- vim.keymap.set("n", "<leader>pg", require("telescope.builtin").git_files)
-- vim.keymap.set("n", "<leader>ps", require("telescope.builtin").live_grep)
-- vim.keymap.set("n", "<leader>pw", require("telescope.builtin").grep_string)
-- vim.keymap.set("n", "<leader>pm", require("telescope.builtin").man_pages)
-- vim.keymap.set("n", "<leader>pn", edit_config)

vim.pack.add({
    {
        src = "https://github.com/nvim-mini/mini.pick",
        version = vim.version.range("0.17.x"),
    },
})

local pick = require("mini.pick")
pick.setup {
    mappings = {
        choose_marked = "<C-q>",
    },
    source = {
        choose_marked = function(items, opts)
            if #items == 0 then
                items = pick.get_picker_matches().all
            end
            pick.default_choose_marked(items, opts)
        end
    },
    window = {
        -- Centered on screen
        config = function()
            local height = math.floor(0.618 * vim.o.lines)
            local width = math.floor(0.618 * vim.o.columns)
            return {
                anchor = 'NW',
                height = height,
                width = width,
                row = math.floor(0.5 * (vim.o.lines - height)),
                col = math.floor(0.5 * (vim.o.columns - width)),
            }
        end
    }
}

vim.keymap.set("n", "<C-p>", pick.builtin.files)
vim.keymap.set("n", "<leader>pg", function() pick.builtin.files { tool = "git" } end)
vim.keymap.set("n", "<leader>ps", pick.builtin.grep_live)
vim.keymap.set("n", "<leader>pw", function() pick.builtin.grep { pattern = vim.fn.expand("<cword>") } end)
vim.keymap.set("n", "<leader>pn", function() pick.builtin.files({}, { source = { cwd = "~/dotconfig" } }) end)
vim.keymap.set("n", "<leader>pr", pick.builtin.resume)
