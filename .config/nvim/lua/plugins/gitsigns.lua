-- show git info in gutter

return function()
    return {
        'lewis6991/gitsigns.nvim',
        config = function()
            local gitsigns = require('gitsigns')
            gitsigns.setup({
                signs = {
                    add = { show_count = true },
                    change = { show_count = true },
                    delete = { show_count = true },
                    topdelete = { show_count = true },
                    changedelete = { show_count = true },
                    untracked = { show_count = true },
                },
                signs_staged = {
                    add = { show_count = true },
                    change = { show_count = true },
                    delete = { show_count = true },
                    topdelete = { show_count = true },
                    changedelete = { show_count = true },
                    untracked = { show_count = true },
                },
                signs_staged_enable = true,
                signcolumn = true,
                numhl = true,
                linehl = false,
                word_diff = false,
                current_line_blame = true,
                current_line_blame_opts = {
                    virt_text_pos = 'right_align',
                    delay = 0,
                },
            })

            -- git reset the hunk under the cursor in visual or normal mode
            vim.keymap.set({ 'n', 'x' }, '<Leader>r', function()
                gitsigns.reset_hunk()
            end, { desc = 'Gitsigns reset hunk' })

            -- show the git diff of the current hunk inline until the cursor is
            -- moved
            vim.keymap.set('n', 'gS', function()
                gitsigns.preview_hunk_inline()
            end, { desc = 'Gitsigns inline diff preview' })

            -- open the git blame tray
            vim.keymap.set('n', 'gb', function()
                gitsigns.blame()
            end, { desc = 'Gitsigns blame' })

            -- populate quickfix list with git diff
            vim.keymap.set('n', 'g<C-q>', function()
                gitsigns.setqflist('all')
            end, { desc = 'Gitsigns send diff to quickfix list' })
        end,
    }
end
