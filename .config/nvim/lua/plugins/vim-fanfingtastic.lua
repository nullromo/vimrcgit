-- allow f, t, F, and T to wrap across lines

return function()
    return {
        'dahu/vim-fanfingtastic',
        keys = { { 'f' }, { 'F' }, { 't' }, { 'T' } },
    }
end
