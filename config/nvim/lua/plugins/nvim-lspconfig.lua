return function()
    return {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
        opts = {
            -- this will get passed into the config function as the second argument
        },
        config = function(_, opts)
            require('lspconfig').lua_ls.setup({
                capabilities = vim.lsp.protocol.make_client_capabilities(),
                on_attach = function()
                    -- do some stuff here
                end,
                settings = {
                    Lua = {
                        -- lua options here?
                    },
                },
            })
        end,
        event = 'VeryLazy',
    }
end
