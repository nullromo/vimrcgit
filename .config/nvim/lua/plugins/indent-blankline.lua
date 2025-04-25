return function()
    local sumiInk1 = '#1F1F28'
    local sumiInk4 = '#54546D'

    return {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            -- add highlight groups
            vim.api.nvim_set_hl(0, 'IndentLevel0', { fg = sumiInk1 })
            vim.api.nvim_set_hl(0, 'IndentLevel1', { fg = sumiInk4 })

            -- construct color list. The first level is the same color as the
            -- background. All levels after that should be the same color
            local colors = {}
            for i = 1, 99 do
                colors[i] = 'IndentLevel1'
            end
            colors[1] = 'IndentLevel0'

            -- setup
            require('ibl').setup({
                indent = { highlight = colors },
                scope = { enabled = false },
            })
        end,
    }
end
