-- allow scrolling past the top of a file

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

            -- Use <C-space> to align top
            vim.keymap.set({ 'n', 'v' }, '<C-Space>', function()
                goUp.align()
            end, { desc = 'align the top of the screen' })
        end,
    }
end
