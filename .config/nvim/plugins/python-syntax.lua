return function()
    return {
        'vim-python/python-syntax',
        init = function ()
            -- Turn on all highlighting
            vim.g.python_highlight_all = 1
        end,
    }
end
