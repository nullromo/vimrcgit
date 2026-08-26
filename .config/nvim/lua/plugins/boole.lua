-- extends <C-a> and <C-x> to toggle booleans

return function()
    return {
        'nat-418/boole.nvim',
        -- Only load on mapped keys
        keys = { '<C-a>', '<C-x>' },
        config = function()
            require('boole').setup({
                mappings = {
                    increment = '<C-a>',
                    decrement = '<C-x>',
                },
            })
        end,
    }
end
