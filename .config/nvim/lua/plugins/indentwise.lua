-- indentation movement mappings

return function()
    return {
        'jeetsukumaran/vim-indentwise',
        -- Load on indentwise's default motion mappings
        keys = {
            { '[-', mode = { 'n', 'v', 'o' } },
            { '[=', mode = { 'n', 'v', 'o' } },
            { '[+', mode = { 'n', 'v', 'o' } },
            { ']-', mode = { 'n', 'v', 'o' } },
            { ']=', mode = { 'n', 'v', 'o' } },
            { ']+', mode = { 'n', 'v', 'o' } },
            { '[_', mode = { 'n', 'v', 'o' } },
            { ']_', mode = { 'n', 'v', 'o' } },
            { '[%', mode = { 'n', 'v', 'o' } },
            { ']%', mode = { 'n', 'v', 'o' } },
        },
    }
end
