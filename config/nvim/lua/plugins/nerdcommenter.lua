return function()
    return {
        'preservim/nerdcommenter',
        config = function ()
            -- Use c/u to comment/uncomment the selection in visual mode
            vim.keymap.set('v', 'c', ":call nerdcommenter#Comment('n', 'Comment')<CR>")
            vim.keymap.set('v', 'u', ":call nerdcommenter#Comment('n', 'Uncomment')<CR>")
        end,
        keys = {
            {
                'c',
                mode = 'v',
            },
            {
                'u',
                mode = 'v'
            },
        },
    }
end
