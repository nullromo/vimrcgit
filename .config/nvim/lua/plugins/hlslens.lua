-- fancier search UI

return function()
    local winterBlue = '#252535'
    local fujiGray = '#727169'
    return {
        'kevinhwang91/nvim-hlslens',
        dependencies = { 'nullromo/go-up.nvim' },
        config = function()
            local hlslens = require('hlslens')
            hlslens.setup()
            local goUp = require('go-up')

            -- set up colors
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
            -- for this one, if you set it to a highlight group, it will
            -- highlight the match nearest to the cursor with that group. I
            -- didn't like that, so I set it to None to preserve vim's default
            -- behavior of the CurSearch highlight. See
            -- https://github.com/kevinhwang91/nvim-hlslens/issues/72 for
            -- details.
            vim.api.nvim_set_hl(0, 'HlSearchNear', { link = 'None' })

            -- trigger hlslens when searching forwards or backwards
            vim.keymap.set('n', 'n', function()
                local ok, _ = pcall(function()
                    vim.cmd('normal! ' .. vim.v.count1 .. 'n')
                end)
                if ok then
                    hlslens.start()
                end
                goUp.centerScreen()
            end, { silent = true, desc = 'hlslens forward search' })
            vim.keymap.set('n', 'N', function()
                local ok, _ = pcall(function()
                    vim.cmd('normal! ' .. vim.v.count1 .. 'N')
                end)
                if ok then
                    hlslens.start()
                end
                goUp.centerScreen()
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
