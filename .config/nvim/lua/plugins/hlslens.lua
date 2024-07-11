return function()
    local winterBlue = '#252535'
    local fujiGray = '#727169'
    return {
        'kevinhwang91/nvim-hlslens',
        config = function()
            local hlslens = require('hlslens')
            hlslens.setup()

            -- set up colors
            vim.api.nvim_set_hl(0, 'HlSearchNear', { link = 'FlashLabel' })
            vim.api.nvim_set_hl(
                0,
                'HlSearchLens',
                { fg = fujiGray, bg = winterBlue }
            )
            vim.api.nvim_set_hl(
                0,
                'HlSearchLensNear',
                { link = 'HlSearchLens' }
            )

            -- trigger hlslens when searching forwards or backwards
            vim.keymap.set('n', 'n', function()
                vim.cmd('normal! ' .. vim.v.count1 .. 'nzz')
                hlslens.start()
            end, { silent = true, desc = 'hlslens forward search' })
            vim.keymap.set('n', 'N', function()
                vim.cmd('normal! ' .. vim.v.count1 .. 'Nzz')
                hlslens.start()
            end, { silent = true, desc = 'hlslens backward search' })

            -- TODO: These are not working because they conflict with my other cash.nvim mappings
            --vim.keymap.set('n', '*', function()
            --vim.cmd('*')
            --hlslens.start()
            --end, { silent = true, desc = 'hlslens * search' })
            --vim.keymap.set('n', '#', function()
            --vim.cmd('#')
            --hlslens.start()
            --end, { silent = true, desc = 'hlslens # search' })
            --vim.keymap.set('n', 'g*', function()
            --vim.cmd('g*')
            --hlslens.start()
            --end, { silent = true, desc = 'hlslens g*' })
            --vim.keymap.set('n', 'g#', function()
            --vim.cmd('g#')
            --hlslens.start()
            --end, { silent = true, desc = 'hlslens g#' })
        end,
    }
end
