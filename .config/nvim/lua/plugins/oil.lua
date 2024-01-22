return function()
    return {
        'stevearc/oil.nvim',
        opts = {},
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('oil').setup({
                default_file_explorer = false,
                columns = {
                    'type',
                    'permissions',
                    'mtime',
                    'size',
                    'icon',
                },
                view_options = {
                    show_hidden = true,
                    sort = { { "name", "asc" } },
                },
            });
        end
    }
end
