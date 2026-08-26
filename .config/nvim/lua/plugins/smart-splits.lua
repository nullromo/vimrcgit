-- make tmux panes work with vim windows. Requires tmux config as well

return function()
    return {
        'mrjones2014/smart-splits.nvim',
        -- Deferred with no key trigger. key-mappings.lua maps <C-h/j/k/l> and
        -- calls require('smart-splits') inside each callback, and lazy.nvim
        -- loads a lua plugin on the first require. Declaring keys here would
        -- make lazy re-map those, clobbering the mappings from
        -- key-mappings.lua
        lazy = true,
        config = function()
            local smartSplits = require('smart-splits')
            smartSplits.setup({ at_edge = 'stop' })
        end,
    }
end
