return function()
    local sumiInk3 = '#363646'

    -- Enable syntax coloring
    vim.opt.syntax = 'on'
    -- Highlights matching parentheses, brackets, etc. on hover
    vim.opt.showmatch = true
    -- Highlight the current line in insert mode
    vim.api.nvim_create_autocmd({'InsertEnter'}, {pattern = '*', command = 'set cursorline'})
    vim.api.nvim_create_autocmd({'InsertLeave'}, {pattern = '*', command = 'set nocursorline'})
    vim.api.nvim_create_autocmd({'BufEnter'}, {pattern = '*', command = 'set nocursorline'})
    -- Turn spell-checking on when editing a .notes file
    vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {pattern = '*', command = 'set nospell'})
    vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {pattern = '*.notes,*.md,*.mdx', command = 'set spell'})
    -- Always show all characters in markdown files
    vim.api.nvim_create_autocmd({'BufEnter', 'BufRead', 'BufNewFile'}, {pattern = '*.md,*.mdx,*.json', command = 'set conceallevel=0'})
    -- Set highlighting for coc to be just bold
    vim.cmd.highlight('CocHighlightText', 'gui=bold')
    -- Set coc autocomplete highlighted line color
    vim.api.nvim_set_hl(0, 'CocMenuSel', { bg = sumiInk3 })
end
