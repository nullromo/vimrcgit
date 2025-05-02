-- use vim in the browser

return function()
    return {
        'glacambre/firenvim',
        lazy = not vim.g.started_by_firenvim,
        module = false,
        build = function()
            vim.fn['firenvim#install'](0)
        end,
        init = function()
            vim.g.firenvim_config = {
                localSettings = {
                    ['.*'] = {
                        takeover = 'never',
                    },
                },
            }
        end,
    }
end
