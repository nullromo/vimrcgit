return function()
    return {
        'nullromo/registereditor',
        config = function()
            local registereditor = require('registereditor')
            registereditor.setup()
        end,
    }
end
