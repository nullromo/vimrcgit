return function()
    return {
        'nullromo/go-up.nvim',
        config = function()
            local goUp = require('go-up')
            goUp.setup()

            -- Use space to center the screen
            vim.keymap.set({ 'n', 'v' }, '<space>', function()
                goUp.centerScreen()
            end, { desc = 'center the screen' })
        end,
    }
end
