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

vim.opt.laststatus = 3 -- global statusline

feline.setup {
    theme = {
        TextActive = "#ffffff",
        TextInactive = "#888888",
        TextSecondary = "#aaaaaa",
        BgPrimary = "#41506d",
        BgSecondary = "#292f3d",
        bg = "#1f222b",
    },
    components = {
        active = {
            -- Left side
            {
                { provider = "  ", hl = { bg = "BgPrimary" } },
                {
                    provider = "vi_mode",
                    icon = "",
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
                        -- { str = " ", hl = { fg = "NONE", bg = "BgSecondary" } },
                    },
                },
                {
                    provider = function()
                        -- Similar to builtin provider "git_branch", but uses vim.g instead of vim.b to show the branch of the working directory, not the file
                        local head = vim.g.gitsigns_head or "-"
                        return "  " .. head
                    end,
                    hl = { fg = "TextInactive", bg = "BgSecondary" },
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
                    right_sep = {
                        { str = "slant_right", hl = { fg = "BgSecondary" }, always_visible = true },
                    },
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
                    hl = { fg = "TextActive", bg = "BgPrimary" },
                    left_sep = { str = "", hl = { fg = "BgPrimary" }, always_visible = true },
                    right_sep = { str = "", hl = { fg = onenord.error, bg = "BgPrimary" }, always_visible = true },
                },
                {
                    provider = diagnostic_provider_for(vim.diagnostic.severity.ERROR),
                    hl = { fg = "TextActive", bg = onenord.error },
                    right_sep = { str = "", hl = { fg = onenord.warn, bg = onenord.error }, always_visible = true },
                },
                {
                    provider = diagnostic_provider_for(vim.diagnostic.severity.WARN),
                    hl = { fg = "TextActive", bg = onenord.warn },
                    right_sep = { str = "", hl = { fg = onenord.info, bg = onenord.warn }, always_visible = true },
                },
                {
                    provider = diagnostic_provider_for(vim.diagnostic.severity.INFO),
                    hl = { fg = "TextActive", bg = onenord.info },
                    right_sep = { str = "", hl = { fg = onenord.hint, bg = onenord.info }, always_visible = true },
                },
                {
                    provider = diagnostic_provider_for(vim.diagnostic.severity.HINT),
                    hl = { fg = "TextActive", bg = onenord.hint },
                    right_sep = { str = "", hl = { fg = "BgSecondary", bg = onenord.hint }, always_visible = true },
                },

                {
                    provider = "line_percentage",
                    hl = { fg = "TextActive", bg = "BgSecondary" },
                    left_sep = { str = " ", hl = { bg = "BgSecondary" } },
                },
                {
                    provider = "file_size",
                    hl = { fg = "TextActive", bg = "BgSecondary" },
                    left_sep = { str = " ", hl = { bg = "BgSecondary" } },
                },
                {
                    provider = "file_type",
                    hl = {
                        fg = "TextInactive",
                        bg = "BgPrimary",
                        style = "bold",
                    },
                    left_sep = {
                        { str = "slant_left", hl = { fg = "BgPrimary", bg = "BgSecondary" } },
                        { str = " ", hl = { bg = "BgSecondary" } },
                        { str = " ", hl = { bg = "BgPrimary" } },
                    },
                },
                { provider = " ", hl = { bg = "BgPrimary" } },
            },
        },
        inactive = {},
    },
}

feline.winbar.setup {
    components = {
        active = {
            {},
            {
                {
                    provider = {
                        name = "file_info",
                        opts = { type = "relative" },
                    },
                    hl = { fg = "TextActive", bg = "NONE", style = "bold" },
                },
                {
                    provider = " @ ",
                    hl = { fg = "TextInactive", bg = "NONE" },
                },
                {
                    provider = "position",
                    hl = { fg = "TextInactive", bg = "NONE" },
                },
            },
        },
        inactive = {
            {},
            {
                {
                    provider = {
                        name = "file_info",
                        opts = { type = "relative" },
                    },
                    hl = { fg = "TextInactive", bg = "NONE" },
                },
                {
                    provider = " @ ",
                    hl = { fg = "TextInactive", bg = "NONE" },
                },
                {
                    provider = "position",
                    hl = { fg = "TextInactive", bg = "NONE" },
                },
            },
        },
    },
}
