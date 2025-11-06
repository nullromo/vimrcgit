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

            -- I don't use these commands and they interfere with :R<Tab>
            vim.api.nvim_del_user_command('RegexplainerClearCache')
            vim.api.nvim_del_user_command('RegexplainerDebug')
            vim.api.nvim_del_user_command('RegexplainerHide')
            vim.api.nvim_del_user_command('RegexplainerShow')
            vim.api.nvim_del_user_command('RegexplainerShowPopup')
            vim.api.nvim_del_user_command('RegexplainerShowSplit')
            vim.api.nvim_del_user_command('RegexplainerToggle')
            vim.api.nvim_del_user_command('RegexplainerYank')
        end,
    }
end
