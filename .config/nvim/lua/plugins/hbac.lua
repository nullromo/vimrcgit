-- auto-close unused buffers

return function()
    return {
        'axkirillov/hbac.nvim',
        config = function()
            require('hbac').setup({
                threshold = 50,
                telescope = {
                    pin_icons = {
                        pinned = { '📌', hl = 'DiagnosticOk' },
                        unpinned = { '⚪', hl = 'DiagnosticError' },
                    },
                },
            })
        end,
    }
end
