return function()
    local sumiInk0 = '#16161D'
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
        end,
        config = function()
            require('kanagawa').setup({
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
            vim.o.background = ''
            vim.cmd.colorscheme('kanagawa')

            -- modify parts of the colorscheme
            vim.api.nvim_set_hl(0, 'StatusLine',  { bg = waveBlue2 })
            vim.api.nvim_set_hl(0, 'TabLine',     { bg = sumiInk0 })
            vim.api.nvim_set_hl(0, 'TabLineFill', { bg = sumiInk0 })
            vim.api.nvim_set_hl(0, 'TabLineSel',  { bg = waveBlue2 })
            vim.api.nvim_set_hl(0, 'CurSearch', { fg = 'black', bg = peachRed })
            vim.api.nvim_set_hl(0, 'Search', { fg = sumiInk0, bg = roninYellow })
            vim.api.nvim_set_hl(0, 'IncSearch', { link = 'Search' })
        end,
    }
end
