return function()
    return {
        'psf/black',
        init = function()
            vim.g.black_skip_magic_trailing_comma = 1
        end,
        config = function()
            vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
                pattern = '*.py',
                command = "execute ':Black'",
                desc = 'format python files on save',
            })
        end,
        ft = { 'python' },
    }
end
