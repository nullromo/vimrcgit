return function()
    local sumiInk3 = '#363646'

    -- Enable syntax coloring
    vim.opt.syntax = 'on'

    -- Highlights matching parentheses, brackets, etc. on hover
    vim.opt.showmatch = true

    -- Highlight the current line in insert mode
    vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
        pattern = '*',
        command = 'set cursorline',
        desc = 'highlight cursor line when entering insert mode',
    })
    vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
        pattern = '*',
        command = 'set nocursorline',
        desc = 'un-highlight cursor line when leaving insert mode',
    })
    vim.api.nvim_create_autocmd({ 'BufEnter' }, {
        pattern = '?',
        command = 'set nocursorline',
        desc = 'un-highlight cursor line when entering a buffer that has a filetype',
    })

    -- Turn spell-checking on when editing a .notes file
    vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
        pattern = '*',
        command = 'set nospell',
        desc = 'disable spell check by default',
    })
    vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
        pattern = '*.notes,*.md,*.mdx',
        command = 'set spell',
        desc = 'enable spell check for certain filetypes',
    })

    -- Always show all characters in markdown files
    vim.api.nvim_create_autocmd(
        { 'BufEnter', 'BufRead', 'BufNewFile', 'FileType' },
        {
            pattern = '*md,*mdx,*json,markdown',
            command = 'set conceallevel=0',
            desc = 'stop character concealment in certain filetypes',
        }
    )

    -- Set highlighting for coc to be just bold
    vim.cmd.highlight('CocHighlightText', 'gui=bold')

    -- Set coc autocomplete highlighted line color
    vim.api.nvim_set_hl(0, 'CocMenuSel', { bg = sumiInk3 })
end
