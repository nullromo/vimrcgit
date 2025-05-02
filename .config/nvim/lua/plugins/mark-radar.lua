-- mark jumping highlighter

return function()
    return {
        'winston0410/mark-radar.nvim',
        config = function()
            require('mark-radar').setup({
                text_position = 'inline',
            })
        end,
    }
end
