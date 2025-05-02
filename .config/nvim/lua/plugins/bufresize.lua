-- maintain window sizes when resizing vim

return function()
    return {
        'kwkarlwang/bufresize.nvim',
        config = function()
            require('bufresize').setup({
                -- register means "save the current window state"
                register = {
                    -- save the window state when opening a new buffer/window,
                    -- when resizing a window, or when closing a window
                    trigger_events = { 'BufWinEnter', 'WinEnter', 'WinResized' },
                },
                -- resize means "apply the saved window state"
                resize = {
                    keys = {},
                    -- apply the saved window state when vim itself is resized
                    trigger_events = { 'VimResized' },
                    increment = false,
                },
            })

            -- keep track of the last action taken so that we can call
            -- resize_open or resize_close appropriately
            local lastAction = ''

            -- when a window is closed, save the current window state and set
            -- the last action to 'close'
            vim.api.nvim_create_autocmd({ 'WinClosed' }, {
                callback = function()
                    lastAction = 'close'
                    require('bufresize').register()
                    require('bufresize').block_register()
                end,
            })

            -- when a window is opened save the current window state and set the
            -- last action to 'open'
            vim.api.nvim_create_autocmd({ 'WinNew' }, {
                callback = function()
                    lastAction = 'open'
                    require('bufresize').register()
                    require('bufresize').block_register()
                end,
            })

            -- when a window is entered, resize based on the last action. Note:
            -- this currently only works for closing windows; when opening
            -- windows there is still a problem. See
            -- https://github.com/kwkarlwang/bufresize.nvim/issues/15 for
            -- details.
            --vim.api.nvim_create_autocmd({ 'BufWinEnter', 'WinEnter' }, {
            --callback = function()
            --if lastAction == 'close' then
            ----vim.notify('doing a close')
            --require('bufresize').resize_close()
            --elseif lastAction == 'open' then
            ----vim.notify('doing an open')
            --require('bufresize').resize_open()
            --end
            --end,
            --})
        end,
    }
end
