-- status updater for LSP

return function()
    return {
        'j-hui/fidget.nvim',
        event = 'LspAttach',
        config = function()
            require('fidget').setup()
        end,
    }
end
