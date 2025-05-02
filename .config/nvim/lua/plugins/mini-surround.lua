-- utility for editing surrounding symbols like quotes and xml tags

return function()
    return {
        'echasnovski/mini.surround',
        version = false,
        config = function()
            require('mini.surround').setup({
                mappings = {
                    add = '<C-s>a',
                    delete = '<C-s>d',
                    find = '', -- '<C-s>f',
                    find_left = '', -- '<C-s>F',
                    highlight = '', -- '<C-s>h',
                    replace = '<C-s>r',
                    update_n_lines = '', -- '<C-s>n',
                    suffix_last = 'p',
                    suffix_next = 'n',
                },
                n_lines = 100,
                respect_selection_type = true,
            })
        end,
    }
end
