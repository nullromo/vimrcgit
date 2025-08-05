-- screensaver

return function()
    return {
        'nullromo/fishtank.nvim',
        config = function()
            local fishtank = require('fishtank')
            fishtank.setup({ screensaver = { enabled = true, timeout = 3000 } })
        end,
    }
end
