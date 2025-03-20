return function()
    return {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = {
            auto_update = true,
            ensure_installed = {
                'typos_lsp',
            },
        },
    }
end
