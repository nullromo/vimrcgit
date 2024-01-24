return function()
    -- Set the auto-formatter for java
    --   NOTE: See http://astyle.sourceforge.net/astyle.html for details
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufRead' },
        {
            pattern = '*.java',
            command = 'set formatprg=astyle -A1s4SM80m0pHyj',
            desc = 'autoformat settings for java',
        }
    )

    -- Make it so that markdown files are formatted properly with gq and also while
    -- typing in the file (automatically). See :h fo-table for details.
    vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' },
        {
            pattern = '*.md',
            command = 'set formatoptions=tcqln',
            desc = 'autoformat settings for markdown',
        }
    )

    -- Make it so that comments and code are formatted properly with gq in C files
    vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' },
        {
            pattern = '*.c,*.cpp,*.h,*.hpp,*.js,*.ts,*.jsx,*.tsx',
            command = 'set formatoptions=croqlj',
            desc = 'autoformat settings for c and javascript',
        }
    )

    -- Add '/**' to the list of allowable comment block starters. The default
    -- setting for this is 'sO:*\ -,mO:*\ ,exO:*/,s1:/*,mb:*,ex:*/,://', so this
    -- setting adds the 's1:/**' option to the list to support Doxygen-style
    -- comments. See :h comments for details.
    vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' },
        {
            pattern = '*.c,*.cpp,*.h,*.hpp,*.js,*.ts,*.jsx,*.tsx',
            command = 'set comments=sO:*\\ -,mO:*\\ ,exO:*/,s1:/**,mb:*,ex:*/,s1:/*,mb:*,ex:*/,://',
            desc = 'comment formatting settings for c and javascript',
        }
    )
end
