return function()
    -- Enable line numbering
    vim.opt.nu = true
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
    vim.opt.backspace = {'indent', 'eol', 'start'}
    -- Auto-insert } when typing {<CR> in insert mode
    vim.keymap.set('i', '{<CR>', '{<CR><CR>}<ESC>kcc')
end
