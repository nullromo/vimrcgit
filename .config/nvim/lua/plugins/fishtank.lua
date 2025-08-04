-- screensaver

return function()
    return {
        'nullromo/fishtank.nvim',
        config = function()
            local fishtank = require('fishtank')
            fishtank.setup()
        end,
    }
end
