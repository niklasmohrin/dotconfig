local builtin = require("el.builtin")
local extensions = require("el.extensions")
local helper = require("el.helper")
local lsp_statusline = require("el.plugins.lsp_status")
local sections = require("el.sections")
local subscribe = require("el.subscribe")
local has_lsp_extensions, ws_diagnostics = pcall(require, 'lsp_extensions.workspace.diagnostic')

local git_changes = subscribe.buf_autocmd(
    "el_git_changes",
    "BufWritePost",
    function(window, buffer)
        return extensions.git_changes(window, buffer)
    end
)

local git_branch = subscribe.buf_autocmd(
    "el_git_branch",
    "BufEnter",
    function(window, buffer)
        local branch = extensions.git_branch(window, buffer)
        if branch then
            return ' ' .. extensions.git_icon() .. ' ' .. branch
        end
    end
)

local show_current_func = function(win_id)
    return helper.async_buf_setter(
        win_id,
        "el_lsp_cur_func",
        function (window, buffer)
            if buffer.filetype == 'lua' then
                return ''
            end
            return lsp_statusline.current_function(window, buffer)
        end,
        10000
    )
end

local file_icon = subscribe.buf_autocmd(
    "el_file_icon",
    "BufRead",
    function(_, buffer)
        return extensions.file_icon(_, buffer)
    end
)

local ws_diagnostic_counts = function(_, buffer)
    if not has_lsp_extensions then
        return ""
    end

    local error_count = ws_diagnostics.get_count(buffer.bufnr, "Error")
    if error_count == 0 then
        return ""
    else
        local x = "⬤"
        error_count = math.min(error_count, 5)
        return string.format('%s#%s#%s%%*', '%', "StatuslineError" .. error_count, x)
    end
end

local generator = function(win_id, _)
    return {
        extensions.gen_mode { format_string = ' %s ' },
        git_branch,
        git_changes,
        sections.split,
        file_icon,
        sections.maximum_width(
            builtin.make_responsive_file(140, 90),
            0.30
        ),
        sections.collapse_builtin {
            ' ',
            builtin.modified_flag
        },
        sections.split,
        lsp_statusline.server_progress,
        ws_diagnostic_counts,
        -- show_current_func(win_id), -- broken
        '[', builtin.line_with_width(3), ':',  builtin.column_with_width(2), ']',
        sections.collapse_builtin {
            '[',
            builtin.help_list,
            builtin.readonly_list,
            ']',
        },
        builtin.filetype,
    }
end

require('el').setup { generator = generator }
