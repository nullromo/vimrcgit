-- status updater for LSP

return function()
    return {
        'j-hui/fidget.nvim',
        event = 'LspAttach',
        config = function()
            require('fidget').setup()

            -- I never use the :Fidget command and it interferes with :F<Tab>
            vim.api.nvim_del_user_command('Fidget')
        end,
    }
end
