return function()
    local sumiInk0 = '#16161D'
    local sumiInk4 = '#54546D'
    local dragonBlue = '#658594'
    local waveBlue2 = '#2D4F67'
    local oldWhite = '#C8C093'
    local autumnYellow = '#DCA561'
    local autumnGreen = '#76946A'
    local roninYellow = '#FF9E3B'
    local peachRed = '#FF5D62'
    return {
        'rebelot/kanagawa.nvim',
        init = function()
            -- stylua: ignore start
            -- set up custom status line highlight groups
            vim.api.nvim_set_hl(0, 'StatusLineGitBranchName',   { fg = 'lightgreen', bg = waveBlue2 })
            vim.api.nvim_set_hl(0, 'StatusLineGitBranchNameNC', { fg = 'lightgreen', bg = sumiInk0  })
            vim.api.nvim_set_hl(0, 'StatusLineFileName',        { fg = 'white',      bg = waveBlue2 })
            vim.api.nvim_set_hl(0, 'StatusLineFileNameNC',      { fg = oldWhite,     bg = sumiInk0  })
            vim.api.nvim_set_hl(0, 'StatusLineNumber',          { fg = autumnGreen,  bg = waveBlue2 })
            vim.api.nvim_set_hl(0, 'StatusLineNumberNC',        { fg = autumnGreen,  bg = sumiInk0  })
            vim.api.nvim_set_hl(0, 'StatusLinePercent',         { fg = autumnYellow, bg = waveBlue2 })
            vim.api.nvim_set_hl(0, 'StatusLinePercentNC',       { fg = autumnYellow, bg = sumiInk0  })
            vim.api.nvim_set_hl(0, 'StatusLineMeta',            { fg = 'white',      bg = waveBlue2 })
            vim.api.nvim_set_hl(0, 'StatusLineMetaNC',          { fg = dragonBlue,   bg = sumiInk0  })

            -- highlight groups for flash.nvim
            vim.api.nvim_set_hl(0, 'FlashLabel',                { fg = 'black',      bg = peachRed  })
            -- stylua: ignore end
        end,
        config = function()
            require('kanagawa').setup({
                undercurl = false,
                theme = 'wave',
                colors = {
                    theme = {
                        all = {
                            ui = {
                                bg_gutter = 'none',
                            },
                        },
                    },
                },
            })

            -- enable the colorscheme
            vim.cmd.colorscheme('kanagawa')

            -- modify parts of the colorscheme
            -- statusline background
            vim.api.nvim_set_hl(0, 'StatusLine', { bg = waveBlue2 })
            -- tabline background
            vim.api.nvim_set_hl(0, 'TabLineFill', { bg = sumiInk0 })
            -- unselected tab title background
            vim.api.nvim_set_hl(0, 'TabLine', { bg = sumiInk0 })
            -- selected tab background
            vim.api.nvim_set_hl(0, 'TabLineSel', { bg = waveBlue2 })
            -- search highlight color
            vim.api.nvim_set_hl(
                0,
                'Search',
                { fg = sumiInk0, bg = roninYellow }
            )
            -- search term that is under the cursor
            vim.api.nvim_set_hl(0, 'CurSearch', { fg = 'black', bg = peachRed })
            -- search term that is being typed out
            vim.api.nvim_set_hl(0, 'IncSearch', { link = 'Search' })
            -- line that separates vertical splits
            vim.api.nvim_set_hl(0, 'WinSeparator', { fg = sumiInk4 })
        end,
    }
end
