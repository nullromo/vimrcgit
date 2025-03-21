return function()
    return {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'williamboman/mason.nvim',
        },
        opts = {
            ensure_installed = { 'lua_ls', 'typos_lsp' },
            automatic_installation = true,
        },
        config = function()
            require('mason').setup()
            -- For some reason, having an empty function here makes this plugin
            -- load after its dependency
        end,
        event = 'VeryLazy',
    }
end
