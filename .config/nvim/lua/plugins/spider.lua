return function()
    return {
        'chrisgrieser/nvim-spider',
        enable = false,
        event = 'VeryLazy',
        config = function()
            require('spider').setup({
                skipInsignificantPunctuation = false,
            })
            -- map w, e, b, and ge for normal and visual modes only. W, E, B,
            -- and gE function normally
            vim.keymap.set(
                { 'n', 'x' },
                'w',
                "<cmd>lua require('spider').motion('w')<CR>",
                { desc = 'Spider w motion' }
            )
            vim.keymap.set(
                { 'n', 'x' },
                'e',
                "<cmd>lua require('spider').motion('e')<CR>",
                { desc = 'Spider e motion' }
            )
            vim.keymap.set(
                { 'n', 'x' },
                'b',
                "<cmd>lua require('spider').motion('b')<CR>",
                { desc = 'Spider b motion' }
            )
            vim.keymap.set(
                { 'n', 'x' },
                'ge',
                "<cmd>lua require('spider').motion('ge')<CR>",
                { desc = 'Spider ge motion' }
            )

            -- use <C-w>, <C-b>, and <C-g>e in insert mode to mimic normal mode
            -- w, b, and ge. Insert mode <C-e> already has a use
            vim.keymap.set(
                'i',
                '<C-w>',
                "<cmd>lua require('spider').motion('w')<CR>",
                { desc = 'Spider insert mode w motion' }
            )
            vim.keymap.set(
                'i',
                '<C-b>',
                "<cmd>lua require('spider').motion('b')<CR>",
                { desc = 'Spider insert mode b motion' }
            )
            vim.keymap.set(
                'i',
                '<C-g>e',
                "<cmd>lua require('spider').motion('ge')<CR>",
                { desc = 'Spider insert mode ge motion' }
            )

            local motionFromInsertMode = require('util').motionFromInsertMode

            -- use <C-S-w>, <C-S-e>, <C-S-b>, and <C-g>E in insert mode to mimic
            -- normal mode W, E, B, and gE
            vim.keymap.set('i', '<C-S-w>', function()
                return motionFromInsertMode('W')
            end, { expr = true, desc = 'Insert mode W motion' })
            vim.keymap.set('i', '<C-S-e>', function()
                return motionFromInsertMode('E')
            end, { expr = true, desc = 'Insert mode E motion' })
            vim.keymap.set('i', '<C-S-b>', function()
                return motionFromInsertMode('B')
            end, { expr = true, desc = 'Insert mode B motion' })
            vim.keymap.set('i', '<C-g>E', function()
                return motionFromInsertMode('gE')
            end, { expr = true, desc = 'Insert mode gE motion' })
        end,
    }
end
