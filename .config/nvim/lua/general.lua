return function()
    -- Make bash aliases work with external commands
    vim.cmd('let $BASH_ENV = "~/.bash_aliases"')

    -- Check for external file updates on buffer enter or idle cursor
    vim.api.nvim_create_autocmd({ 'BufEnter' }, {
        pattern = '*',
        command = ':checktime',
        desc = 'check for file updates when entering buffer',
    })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        pattern = '*',
        command = 'checktime',
        desc = 'check for file updates when idle',
    })
end
