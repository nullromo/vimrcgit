return function()
    return {
        'nullromo/cash.nvim',
        config = function()
            local cash = require('cash')
            cash.setup()
        end,
    }
end
