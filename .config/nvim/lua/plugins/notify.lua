return function()
    return {
        'nullromo/nvim-notify',
        config = function()
            require('notify').setup({
                max_width = 100,
                max_height = 100,
                on_open = function() end,
                on_close = function() end,
                background_colour = 'NotifyBackground',
                fps = 1,
                icons = {
                    DEBUG = 'DEBUG',
                    ERROR = 'ERROR',
                    INFO = 'INFO',
                    TRACE = 'TRACE',
                    WARN = 'WARNING',
                },
                level = 2,
                minimum_width = 50,
                render = 'compact',
                stages = 'fade_in_slide_out',
                time_formats = {
                    notification = '%T',
                    notification_history = '%FT%T',
                },
                timeout = 2000,
                top_down = false,
            })
            vim.notify = require('notify')
        end,
    }
end
