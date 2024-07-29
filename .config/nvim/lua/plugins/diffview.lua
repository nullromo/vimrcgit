return function()
    return {
        'sindrets/diffview.nvim',
        config = function()
            require('diffview').setup({
                file_panel = {
                    tree_options = {
                        flatten_dirs = false,
                    },
                    win_config = {
                        position = 'top',
                        height = 16,
                    },
                },
            })
        end,
    }
end
