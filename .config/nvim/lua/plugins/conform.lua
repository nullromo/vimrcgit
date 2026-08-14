-- nvim auto formatter

-- The "bundled" prettier is the prettier that ships inside coc-prettier. This
-- is always present, so it serves as the last-resort formatter when there is
-- neither a project-local nor a global install. It is a .cjs file, but it
-- carries a '#!/usr/bin/env node' shebang and the executable bit, so it can be
-- run directly.
local BUNDLED_PRETTIER = vim.fn.expand(
    '~/.config/coc/extensions/node_modules/coc-prettier/node_modules/prettier/bin/prettier.cjs'
)

-- Resolve prettier in three tiers, most project-specific first:
--   1. The project's own node_modules/.bin/prettier
--   2. The global install on $PATH, for repos with no local prettier
--   3. The copy bundled with coc-prettier, in case the global one is missing
local function prettier_command(self, ctx)
    local project = require('conform.util').find_executable({
        'node_modules/.bin/prettier',
    }, '')(self, ctx)
    if project ~= '' then
        return project
    end

    if vim.fn.executable('prettier') == 1 then
        return 'prettier'
    end

    return BUNDLED_PRETTIER
end

return function()
    return {
        'stevearc/conform.nvim',
        event = { 'BufWritePre' },
        cmd = { 'ConformInfo' },
        opts = {
            formatters_by_ft = {
                cpp = { 'clang_format' },
                lua = { 'stylua' },
                markdown = { 'prettier' },
            },
            -- Override only the command of conform's built-in prettier; its
            -- args and cwd handling are kept as-is
            formatters = { prettier = { command = prettier_command } },
            format_on_save = { timeout_ms = 1800, lsp_fallback = true },
        },
        init = function()
            --vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    }
end
