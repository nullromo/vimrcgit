return function()
    return {
        'm4xshen/hardtime.nvim',
        dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
        config = function()
            require('hardtime').setup({
                disable_mouse = false,
                restriction_mode = 'hint',
            })
        end,
    }
end
