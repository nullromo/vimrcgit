return function()
    return {
        'stevearc/conform.nvim',
        config = function()
            local conform = require('conform')

            conform.setup({
                formatters_by_ft = {
                    lua = { 'stylua' },
                },
            })

            vim.api.nvim_create_autocmd('BufWritePre', {
                pattern = '*.lua',
                callback = function(args)
                    conform.format({ bufnr = args.buf })
                end,
            })
        end,
    }
end
