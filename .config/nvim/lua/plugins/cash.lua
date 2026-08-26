-- search highlighting tool

return function()
    return {
        'nullromo/cash.nvim',
        branch = 'main',
        config = function()
            local cash = require('cash')
            cash.setup({
                --autoNoHighlight = true,
                chooser = { position = 'bottom-right' },
                drawer = { detailPane = true },
                indicator = {
                    show = true,
                    brackets = 'angle',
                    display = 'number-and-pattern',
                    style = 'strip',
                    position = 'top-right',
                },
                -- n and N are mapped in plugins/hlslens.lua instead, and that
                -- mapping calls cash.nextMatch and cash.previousMatch. If this
                -- setting is left on, both plugins would map n at load time
                -- and whichever loads last would win. The load order is not
                -- the same one every session, so that's bad
                manageJumps = false,
            })
        end,
    }
end
