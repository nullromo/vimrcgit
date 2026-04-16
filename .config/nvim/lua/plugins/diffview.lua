-- diff viewer

return function()
    return {
        'sindrets/diffview.nvim',
        config = function()
            require('diffview').setup({
                view = { merge_tool = { layout = 'diff4_mixed' } },
                file_panel = {
                    tree_options = {
                        flatten_dirs = false,
                    },
                },
                hooks = {
                    diff_buf_win_enter = function()
                        vim.opt.foldenable = false
                    end,
                },
            })
        end,
    }
end
