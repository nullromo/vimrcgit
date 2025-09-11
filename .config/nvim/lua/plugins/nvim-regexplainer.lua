return function()
    return {
        'bennypowers/nvim-regexplainer',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'MunifTanjim/nui.nvim',
        },
        config = function()
            local regexplainer = require('regexplainer')
            regexplainer.setup({
                mode = 'narrative',
                --mode = 'graphical',
                auto = true,
                display = 'popup',
                --mappings = { toggle = 'gR' },
            })
        end,
    }
end
