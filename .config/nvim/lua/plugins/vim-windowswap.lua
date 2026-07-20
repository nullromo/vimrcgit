-- allows swapping windows with <leader>w

return function()
    return {
        'wesQ3/vim-windowswap',
        init = function()
            -- Prevent default bindings
            vim.g.windowswap_map_keys = 0
        end,
        config = function()
            -- keep track of marked buffer number
            local markedBuffer = nil

            -- Use ,w to 'yank' and 'paste' windows
            vim.keymap.set('n', '<Leader>w', function()
                -- track marked buffer
                if markedBuffer == nil then
                    markedBuffer = vim.api.nvim_get_current_buf()
                    vim.notify('Yanked buffer ' .. markedBuffer)
                else
                    vim.notify(
                        'Swapped buffers '
                            .. markedBuffer
                            .. ' and '
                            .. vim.api.nvim_get_current_buf()
                    )
                    markedBuffer = nil
                end

                -- call windowswap
                vim.cmd(':call WindowSwap#EasyWindowSwap()')
            end, { silent = true, desc = 'window swap' })
        end,
        keys = { { '<Leader>w', mode = 'n' } },
    }
end
