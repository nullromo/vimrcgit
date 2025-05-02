-- allows swapping windows with <leader>w

return function()
    return {
        'wesQ3/vim-windowswap',
        init = function()
            -- Prevent default bindings
            vim.g.windowswap_map_keys = 0
        end,
        config = function()
            -- Use ,w to 'yank' and 'paste' windows
            vim.keymap.set(
                'n',
                '<Leader>w',
                ':call WindowSwap#EasyWindowSwap()<CR>',
                { silent = true, desc = 'window swap' }
            )
        end,
        keys = {
            {
                '<Leader>w',
                mode = 'n',
            },
        },
    }
end
