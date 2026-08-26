-- find-and-replacer

return function()
    return {
        'nvim-pack/nvim-spectre',
        -- only load when :Spectre is run
        cmd = 'Spectre',
        config = function()
            require('spectre').setup({
                live_update = true,
            })
        end,
    }
end
