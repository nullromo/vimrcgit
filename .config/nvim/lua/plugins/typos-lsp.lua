return function()
    return {
        'tekumara/typos-lsp',
        dependencies = {
            'williamboman/mason.nvim',
        },
        config = function()
            require('lspconfig').typos_lsp.setup({
                init_options = {
                    diagnosticSeverity = 'Error',
                },
            })
        end,
    }
end
