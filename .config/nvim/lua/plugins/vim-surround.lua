-- utility for editing surrounding symbols like quotes and XML tags

return function()
    return {
        'tpope/vim-surround',
        keys = {
            {
                'S',
                mode = 'v',
            },
        },
    }
end
