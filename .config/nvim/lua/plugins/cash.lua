-- search highlighting tool

return function()
    return {
        'nullromo/cash.nvim',
        branch = 'main',
        config = function()
            local cash = require('cash')
            cash.setup()

            -- use <Leader>v to print debug info
            vim.keymap.set('n', '<Leader>v', function()
                cash.printDebugInfo()
            end, { desc = 'cash debug' })
        end,
    }
end
