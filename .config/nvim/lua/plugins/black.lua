-- autoformatting for python

-- Note: to get this to work, you have to follow these steps
--   mkdir -p ~/.local/venv && cd ~/.local/venv
--   python3 -m venv nvim
--   cd nvim
--   . ./bin/activate
--   pip install pynvim black
return function()
    return {
        'averms/black-nvim',
        init = function()
            vim.g.black_skip_magic_trailing_comma = 1
            vim.g.python3_host_prog = os.getenv('HOME')
                .. '/.local/venv/nvim/bin/python'
        end,
        config = function()
            vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
                pattern = '*.py',
                command = 'call BlackSync()',
                desc = 'format python files on save',
            })
        end,
        ft = { 'python' },
    }
end
