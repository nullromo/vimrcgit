return function()
    return {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'folke/neodev.nvim',
        },
        config = function()
            require('neodev').setup({})
            require('lspconfig').lua_ls.setup({
                capabilities = vim.lsp.protocol.make_client_capabilities(),
                on_attach = function()
                    -- do some stuff here
                end,
                settings = {
                    Lua = {
                        workspace = {
                            checkThirdParty = false,
                        },
                    },
                },
            })
        end,
        event = 'VeryLazy',
    }
end
