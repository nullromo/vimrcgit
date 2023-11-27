return function()
    local sumiInk0 = '#16161D'
    local sumiInk1 = '#1F1F28'
    local sumiInk4 = '#54546D'
    local dragonBlue = '#658594'
    local waveBlue2 = '#2D4F67'
    local oldWhite = '#C8C093'
    local autumnYellow = '#DCA561'
    local autumnGreen = '#76946A'
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
        end,
        config = function()
            require('kanagawa').setup({
                theme = 'wave',
            })
            -- enable the colorscheme
            vim.o.background = ''
            vim.cmd.colorscheme('kanagawa')

            -- modify the statusline and tabline highlight colors
            vim.api.nvim_set_hl(0, 'StatusLine',  { bg = waveBlue2 })
            vim.api.nvim_set_hl(0, 'TabLine',     { bg = sumiInk0 })
            vim.api.nvim_set_hl(0, 'TabLineFill', { bg = sumiInk0 })
            vim.api.nvim_set_hl(0, 'TabLineSel',  { bg = waveBlue2 })
            vim.api.nvim_set_hl(0, 'LineNr',      { fg = sumiInk4, bg = sumiInk1 })
        end,
    }
end
