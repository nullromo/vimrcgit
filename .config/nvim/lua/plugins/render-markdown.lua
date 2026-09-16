-- markdown rendering inside vim

return function()
    return {
        'meanderingprogrammer/render-markdown.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            --'nvim-tree/nvim-web-devicons',
        },
        opts = {},
    }
end
