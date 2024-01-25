return function()
    return {
        'folke/flash.nvim',
        opts = {
            label = {
                -- only use lowercase letters for jump labels
                uppercase = false,
                -- use <CR> as the first label
                current = false,
                -- position the labels at the beginning of the search words
                after = false,
                before = true,
            },
            highlight = {
                -- don't blank out the entire screen when using flash
                backdrop = false,
            },
            modes = {
                search = {
                    -- don't do flash when not doing flash
                    enabled = false,
                },
                char = {
                    search = {
                        -- wrap around the end of the document
                        wrap = true,
                    },
                    highlight = {
                        -- don't blank out the entire screen when using flash
                        backdrop = false,
                        groups = {
                            -- highlight the characters in orange instead of red
                            label = 'FlashMatch',
                        },
                    },
                    char_actions = function(motion)
                        -- make f, t, F, and T move in the correct directions
                        return {
                            [motion:lower()] = 'right',
                            [motion:upper()] = 'left',
                        }
                    end,
                },
            },
        },
        config = function(_, opts)
            require('flash').setup(opts)

            -- use C-f to activate flash during normal mode, operator pending
            -- mode, and visual mode
            vim.keymap.set({ 'n', 'o', 'x' }, '<C-f>', function()
                require('flash').jump()
            end, { desc = 'flash' })

            -- use r to activate remote flash in operator pending mode
            vim.keymap.set({ 'o' }, 'r', function()
                require('flash').remote()
            end, { desc = 'remote flash' })
        end,
        --keys = {
        --{ 'S', mode = { 'n', 'o', 'x' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
        --{ 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
        --},
        event = 'VeryLazy',
    }
end
