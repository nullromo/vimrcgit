return function()
    return {
        'kwkarlwang/bufresize.nvim',
        config = function()
        require('bufresize').setup({
            register = {
                trigger_events = { 'BufWinEnter', 'WinEnter', 'WinResized' },
            },
            resize = {
                keys = {},
                trigger_events = { 'VimResized' },
                increment = false,
            },
        })
        end
    }
end
