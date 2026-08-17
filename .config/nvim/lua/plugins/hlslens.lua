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

            -- trigger hlslens from *, #, g*, and g#
            --
            -- These cannot just be mapped. cash.nvim and registereditor both
            -- map all four, and both of them wrap whatever is already on the
            -- key at the moment they load. A mapping written here would
            -- therefore sometimes wrap them and sometimes be wrapped by them,
            -- depending on a load order that is not the same every session.
            -- Waiting for VimEnter puts this link at the end of the chain
            -- every time, no matter who else got there first.
            local startLensAfter = function(key)
                local existing = vim.fn.maparg(key, 'n', false, true)

                vim.keymap.set('n', key, function()
                    -- do whatever was already on the key
                    if next(existing) == nil then
                        vim.cmd('normal! ' .. vim.v.count1 .. key)
                    elseif existing.callback ~= nil then
                        local keys = existing.callback()

                        -- an expr mapping hands back the keys to run rather
                        -- than running them, and the count has to be put back
                        -- in front (this mapping has already taken it off)
                        if existing.expr == 1 and type(keys) == 'string' then
                            vim.api.nvim_feedkeys(
                                vim.v.count1
                                    .. vim.api.nvim_replace_termcodes(
                                        keys,
                                        true,
                                        false,
                                        true
                                    ),
                                -- no remapping, and run it now rather than
                                -- leaving it queued behind the lens starting
                                'nx',
                                false
                            )
                        end
                    else
                        vim.cmd(
                            'normal! '
                                .. vim.v.count1
                                .. vim.api.nvim_replace_termcodes(
                                    existing.rhs,
                                    true,
                                    false,
                                    true
                                )
                        )
                    end

                    -- this is scheduled for one tick later because cash does
                    -- its half of * and # from a schedule and that is what
                    -- sets @/
                    vim.schedule(function()
                        hlslens.start()
                    end)
                end, {
                    silent = true,
                    desc = 'hlslens ' .. key .. ' search',
                })
            end
            vim.api.nvim_create_autocmd('VimEnter', {
                once = true,
                callback = function()
                    for _, key in ipairs({ '*', '#', 'g*', 'g#' }) do
                        startLensAfter(key)
                    end
                end,
            })
        end,
    }
end
