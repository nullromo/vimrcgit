-- splash screen

return function()
    local waveBlue2 = '#2D4F67'

    return {
        'nullromo/minintro.nvim',
        config = function()
            require('minintro').setup({ color = waveBlue2 })
        end,
    }
end
