-- automatically insert matching parentheses and quotes

return function()
    return {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            local nvimAutopairs = require('nvim-autopairs')
            nvimAutopairs.setup({})
        end,
    }
end
