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

            -- trigger hlslens when searching forwards or backwards.
            --
            -- The jump itself goes through cash.nvim rather than through
            -- vim's own n because
            --   1. It visits the matches of every cash register in the search
            --      set instead of only the working one (see cash's manageJumps
            --      option) this
            --   2. It tells cash not to clear highlights (see cash's
            --      autoNoHighlight option)
            --
            -- Counts, vim's wrap message, and vim's not-found message all
            -- still work
            vim.keymap.set('n', 'n', function()
                require('cash').nextMatch()
                hlslens.start()
                goUp.centerScreen()
            end, { silent = true, desc = 'hlslens forward search' })
            vim.keymap.set('n', 'N', function()
                require('cash').previousMatch()
                hlslens.start()
                goUp.centerScreen()
            end, { silent = true, desc = 'hlslens backward search' })
        end,
    }
end
