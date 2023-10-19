return function()
    return {
        'wellle/context.vim',
        init = function ()
            -- Turn off by default
            vim.g.context_enabled = 0
            vim.g.context_highlight_tag = '<hide>'
        end,
        config = function ()
            -- Create a command to peek at the current context
            vim.api.nvim_create_user_command('Context', 'normal :ContextPeek<CR>', {bang = true})
        end,
        cmd = 'Context',
    }
end
