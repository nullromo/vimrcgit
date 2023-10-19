return function()
    return {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'williamboman/mason.nvim'
        },
        opts = {
            ensure_installed = {
                'lua_ls'
            },
            automatic_installation = true,
        },
        config = function()
            -- For some reason, having an empty function here makes this plugin
            -- load after its dependency
        end,
        event = 'VeryLazy',
    }
end
