-- search highlighting tool

return function()
    return {
        'nullromo/cash.nvim',
        branch = 'main',
        config = function()
            local cash = require('cash')
            cash.setup({
                autoNoHighlight = true,
                chooser = { position = 'bottom-right' },
                drawer = { detailPane = true },
            })
        end,
    }
end
