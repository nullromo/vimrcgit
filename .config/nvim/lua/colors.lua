return function()
    -- Enable syntax coloring
    vim.opt.syntax = 'on'
    -- Set the color scheme
    vim.cmd.colorscheme('kyle')
    -- Highlights matching parentheses, brackets, etc. on hover
    vim.opt.showmatch = true
    -- Highlight the current line in insert mode
    vim.api.nvim_create_autocmd({'InsertEnter'}, {pattern = '*', command = 'set cul'})
    vim.api.nvim_create_autocmd({'InsertLeave'}, {pattern = '*', command = 'set nocul'})
    vim.api.nvim_create_autocmd({'BufRead'}, {pattern = '*', command = 'set nocul'})
    -- Turn spell-checking on when editing a .notes file
    vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {pattern = '*', command = 'set nospell'})
    vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {pattern = '*.notes,*.md,*.mdx', command = 'set spell'})
    -- Always show all characters in markdown files
    vim.api.nvim_create_autocmd({'BufEnter', 'BufRead', 'BufNewFile'}, {pattern = '*.md,*.mdx,*.json', command = 'set conceallevel=0'})
    -- Set highlighting for coc to be just bold
    vim.cmd.highlight({'CocHighlightText', 'cterm=bold'})
end
