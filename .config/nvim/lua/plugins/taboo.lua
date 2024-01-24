return function()
    return {
        'gcmt/taboo.vim',
        init = function ()
            -- Allows tab names to be saved in the session file
            vim.opt.sessionoptions = {
                'blank',
                'buffers',
                'curdir',
                'folds',
                'globals',
                'help',
                'localoptions',
                'options',
                'resize',
                'tabpages',
                'terminal',
                'winpos',
                'winsize',
            }

            -- Set the tab format for default tabs
            vim.g.taboo_tab_format = '├%N%U╯%f %m'

            -- Set the tab format for renamed tabs
            vim.g.taboo_renamed_tab_format = '├%N%U╯%l %m'

            -- Put a clock in the top-right corner of the tabline
            vim.g.taboo_close_tabs_label = "%{substitute(strftime('%a %e %b %l:%M:%S %p'), '  ', ' ', 'g')}"

            -- Update the clock whenever possible (when the cursor moves)
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' },
                {
                    pattern = '*',
                    command = 'silent redrawtabline',
                    desc = 'update clock when idle',
                }
            )

            -- Always show the tabline
            vim.opt.showtabline = 2
        end,
        config = function ()
            -- Redraw the tabline every minute to update the clock
            vim.cmd([[
                function RedrawTabline(timerID) abort
                    silent redrawtabline
                endfunction
                call timer_start(60000, 'RedrawTabline', {'repeat': -1})
            ]])
        end,
        lazy = false,
    }
end
