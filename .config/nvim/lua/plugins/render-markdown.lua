-- markdown rendering inside vim

return function()
    return {
        'meanderingprogrammer/render-markdown.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            --'nvim-tree/nvim-web-devicons',
        },
        opts = {
            file_types = { 'markdown', 'markdown.mdx' },
            html = { comment = { conceal = false } },
        },
    }
end
