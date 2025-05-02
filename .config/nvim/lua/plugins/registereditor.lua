-- easy way to edit registers

return function()
    return {
        -- this is a fork of tuurep/registereditor. See
        -- https://github.com/tuurep/registereditor/pull/6 and
        -- https://github.com/tuurep/registereditor/pull/7
        'nullromo/registereditor',
        branch = 'multiple-edit',
        config = function()
            local registereditor = require('registereditor')
            registereditor.setup()
        end,
    }
end
