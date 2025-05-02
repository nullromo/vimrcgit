-- buffer jumping

return function()
    return {
        'kwkarlwang/bufjump.nvim',
        config = function()
            require('bufjump').setup({
                forward_key = '<M-i>',
                backward_key = '<M-o>',
                on_success = nil,
            })
        end,
    }
end
