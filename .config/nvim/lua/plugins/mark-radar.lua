return function()
    return {
        'nullromo/mark-radar.nvim',
        config = function()
            require('mark-radar').setup({
                text_position = 'inline',
            })
        end,
    }
end
