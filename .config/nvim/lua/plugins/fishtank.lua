-- screensaver

return function()
    return {
        'nullromo/fishtank.nvim',
        config = function()
            local fishtank = require('fishtank')
            fishtank.setup({
                screensaver = {
                    enabled = true,
                    timeout = 5 * 60 * 1000, -- 5 minutes
                },
            })
        end,
    }
end
