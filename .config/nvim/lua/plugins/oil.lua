-- file browser for editing file names/permissions

return function()
    return {
        'stevearc/oil.nvim',
        -- only load when :Oil is run. Safe because default_file_explorer
        -- is false below, so oil never needs to intercept a file open
        cmd = 'Oil',
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
                    sort = { { 'name', 'asc' } },
                },
            })
        end,
    }
end
