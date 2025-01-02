return function()
    -- Enable line numbering
    vim.opt.nu = true
    vim.opt.relativenumber = false

    -- Set length of a tab
    vim.opt.tabstop = 4

    -- Enable auto indent after return
    vim.opt.autoindent = true

    -- Enable smarter auto indenting
    vim.opt.smartindent = true

    -- Use spaces instead of tabs
    vim.opt.expandtab = true

    -- When using >> to indent, use indent size 4
    vim.opt.shiftwidth = 4

    -- Allow backspacing over everything in insert mode
    vim.opt.backspace = '2'

    -- Keep 4 lines above/below cursor
    vim.opt.scrolloff = 4

    -- Make the backspace key work
    vim.opt.backspace = { 'indent', 'eol', 'start' }

    -- Auto-insert } when typing {<CR> in insert mode
    vim.keymap.set(
        'i',
        '{<CR>',
        '{<CR><CR>}<ESC>kcc',
        { desc = 'auto-insert }' }
    )

    -- Use <S-CR> to insert a newline above the current line in insert mode
    vim.keymap.set(
        'i',
        '<S-CR>',
        '<ESC>O',
        { desc = 'insert newline above current line' }
    )

    -- use proper settings for yaml files
    vim.api.nvim_create_autocmd(
        'FileType',
        { pattern = 'yaml', command = 'setlocal shiftwidth=4 tabstop=4' }
    )
end
