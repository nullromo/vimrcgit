return function()
    return {
        'kwkarlwang/bufjump.nvim',
        config = function()
            require('bufjump').setup({
                forward = '<M-n>',
                backward = '<M-p>',
                on_success = nil,
            })
        end,
    }
end
