require("gitsigns").setup()
local feline = require "feline"
local vi_mode_utils = require "feline.providers.vi_mode"
local onenord = require("onenord.colors").load()

-- Adapted from https://github.com/EdenEast/nyx/blob/8a9819e/config/.config/nvim/lua/eden/modules/ui/feline/init.lua
local function diagnostic_provider_for(severity)
    return function()
        local count = #vim.diagnostic.get(0, { severity = severity })
        return (count > 0) and " " .. count .. " " or ""
    end
end

vim.opt.showmode = false
vim.opt.laststatus = 3 -- global statusline

feline.setup {
    theme = {
        TextPrimary = "#ffffff",
        TextSecondary = "#888888",
        BgPrimary = "#41506d",
        BgSecondary = "#292f3d",
        bg = "#1f222b",
    },
    vi_mode_colors = {
        NORMAL = onenord.fg_light,
        OP = onenord.fg_light,

        INSERT = onenord.green,
        REPLACE = onenord.light_green,
        ["V-REPLACE"] = onenord.light_green,

        VISUAL = onenord.red,
        LINES = onenord.dark_pink,
        BLOCK = onenord.pink,
        SELECT = onenord.dark_red,

        COMMAND = onenord.purple,
        TERM = onenord.light_purple,

        -- Don't know what these are
        ENTER = onenord.cyan,
        MORE = onenord.cyan,
        SHELL = onenord.cyan,

        NONE = "BgPrimary",
    },
    components = {
        active = {
            -- Left side
            {
                { provider = "  ", hl = { bg = "BgPrimary" } },
                {
                    provider = {
                        name = "vi_mode",
                        opts = {
                            show_mode_name = true,
                        },
                    },
                    hl = function()
                        return {
                            name = vi_mode_utils.get_mode_highlight_name(),
                            fg = vi_mode_utils.get_mode_color(),
                            bg = "BgPrimary",
                            style = "bold",
                        }
                    end,
                    right_sep = {
                        { str = " ", hl = { fg = "NONE", bg = "BgPrimary" } },
                        { str = "slant_right_2", hl = { fg = "BgPrimary", bg = "BgSecondary" } },
                    },
                },
                {
                    provider = function()
                        -- Similar to builtin provider "git_branch", but uses vim.g instead of vim.b to show the branch of the working directory, not the file
                        local head = vim.g.gitsigns_head or "-"
                        return "  " .. head
                    end,
                    hl = { fg = "TextSecondary", bg = "BgSecondary" },
                    left_sep = { str = " ", hl = { fg = "NONE", bg = "BgSecondary" } },
                },
                {
                    provider = "git_diff_added",
                    icon = " +",
                    hl = { fg = onenord.diff_add, bg = "BgSecondary" },
                },
                {
                    provider = "git_diff_changed",
                    icon = " ~",
                    hl = { fg = onenord.diff_change, bg = "BgSecondary" },
                },
                {
                    provider = "git_diff_removed",
                    icon = " -",
                    hl = { fg = onenord.diff_remove, bg = "BgSecondary" },
                },
                {
                    hl = { fg = onenord.diff_remove, bg = "BgSecondary" },
                    left_sep = { str = " ", hl = { fg = "NONE", bg = "BgSecondary" }, always_visible = true },
                    right_sep = { str = "slant_right", hl = { fg = "BgSecondary" }, always_visible = true },
                },
                -- Empty component to fix the highlight till the end of the statusline
                {},
            },
            -- Right side
            {
                {
                    provider = function()
                        return vim.trim(require("lsp-status").status())
                    end,
                    hl = { fg = "TextPrimary", bg = "BgPrimary" },
                    left_sep = { str = "", hl = { fg = "BgPrimary" }, always_visible = true },
                    right_sep = { str = "", hl = { fg = onenord.error, bg = "BgPrimary" }, always_visible = true },
                },
                {
                    provider = diagnostic_provider_for(vim.diagnostic.severity.ERROR),
                    hl = { fg = "TextPrimary", bg = onenord.error },
                    right_sep = { str = "", hl = { fg = onenord.warn, bg = onenord.error }, always_visible = true },
                },
                {
                    provider = diagnostic_provider_for(vim.diagnostic.severity.WARN),
                    hl = { fg = "TextPrimary", bg = onenord.warn },
                    right_sep = { str = "", hl = { fg = onenord.info, bg = onenord.warn }, always_visible = true },
                },
                {
                    provider = diagnostic_provider_for(vim.diagnostic.severity.INFO),
                    hl = { fg = "TextPrimary", bg = onenord.info },
                    right_sep = { str = "", hl = { fg = onenord.hint, bg = onenord.info }, always_visible = true },
                },
                {
                    provider = diagnostic_provider_for(vim.diagnostic.severity.HINT),
                    hl = { fg = "TextPrimary", bg = onenord.hint },
                    right_sep = { str = "", hl = { fg = "BgSecondary", bg = onenord.hint }, always_visible = true },
                },

                {
                    provider = "line_percentage",
                    hl = { fg = "TextPrimary", bg = "BgSecondary" },
                    left_sep = { str = " ", hl = { bg = "BgSecondary" } },
                },
                {
                    provider = "file_size",
                    hl = { fg = "TextPrimary", bg = "BgSecondary" },
                    left_sep = { str = " ", hl = { bg = "BgSecondary" } },
                    right_sep = { str = " ", hl = { bg = "BgSecondary" } },
                },
                {
                    provider = "file_type",
                    hl = {
                        fg = "TextSecondary",
                        bg = "BgPrimary",
                        style = "bold",
                    },
                    left_sep = {
                        { str = "slant_left", hl = { fg = "BgPrimary", bg = "BgSecondary" }, always_visible = true },
                        -- { str = " ", hl = { bg = "BgSecondary" }, always_visible = true },
                        { str = " ", hl = { bg = "BgPrimary" }, always_visible = true },
                    },
                },
                { provider = " ", hl = { bg = "BgPrimary" } },
            },
        },
        inactive = {},
    },
}

local function make_winbar_components(is_active)
    local text_fg = is_active and "TextPrimary" or "TextSecondary"
    local text_bg = is_active and "BgPrimary" or "BgSecondary"
    return {
        { { hl = { bg = "NONE" } } },
        {
            {
                provider = {
                    name = "file_info",
                    opts = { type = "relative" },
                },
                hl = { fg = text_fg, bg = text_bg, style = "bold" },
                left_sep = {
                    { str = "slant_left_2", hl = { fg = text_bg, bg = "NONE" } },
                    -- { str = " ", hl = { bg = "NONE" } },
                    { str = " ", hl = { bg = text_bg } },
                },
            },
            {
                provider = " @ ",
                hl = { fg = "TextSecondary", bg = text_bg },
            },
            {
                provider = "position",
                hl = { fg = "TextSecondary", bg = text_bg },
            },
        },
    }
end

feline.winbar.setup {
    components = {
        active = make_winbar_components(true),
        inactive = make_winbar_components(false),
    },
}
