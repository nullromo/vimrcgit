-- nvim auto formatter

return function()
    return {
        'stevearc/conform.nvim',
        event = { 'BufWritePre' },
        cmd = { 'ConformInfo' },
        opts = {
            formatters_by_ft = { cpp = { 'clang_format' }, lua = { 'stylua' } },
            format_on_save = { timeout_ms = 500, lsp_fallback = true },
        },
        init = function()
            --vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    }
end
