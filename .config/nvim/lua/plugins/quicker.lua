return function()
    return {
        'stevearc/quicker.nvim',
        dependencies = {
            'stevearc/qf_helper.nvim',
        },
        config = function()
            local quicker = require('quicker')

            -- use ,q to open/close the quickfix list
            vim.keymap.set('n', '<leader>q', function()
                quicker.toggle({ focus = true, max_height = 20 })
            end, {
                desc = 'toggle quickfix',
            })

            -- Use [q and ]q to navigate quickfix list items faster
            -- Use [Q and ]Q to navigate quickfix files faster
            vim.keymap.set(
                'n',
                '[q',
                ':cprevious<CR>',
                { desc = 'quickfix previous item' }
            )
            vim.keymap.set(
                'n',
                ']q',
                ':cnext<CR>',
                { desc = 'quickfix next item' }
            )
            vim.keymap.set(
                'n',
                '[Q',
                ':cpfile<CR>',
                { desc = 'quickfix previous file' }
            )
            vim.keymap.set(
                'n',
                ']Q',
                ':cnfile<CR>',
                { desc = 'quickfix next file' }
            )

            quicker.setup({
                keys = {
                    {
                        '>',
                        function()
                            quicker.expand({
                                before = 2,
                                after = 2,
                                add_to_existing = true,
                            })
                        end,
                        desc = 'Expand quickfix context',
                    },
                    {
                        '<',
                        function()
                            quicker.collapse()
                        end,
                        desc = 'Collapse quickfix context',
                    },
                },
            })

            -- This plugin closes the quickfix window when it's the only window
            -- left. It also helps the highlighted quickfix item change when
            -- scrolling through a file while the quickfix window is open
            require('qf_helper').setup({
                quickfix = {
                    default_bindings = false,
                    max_height = 20,
                    min_height = 4,
                },
            })
        end,
    }
end
