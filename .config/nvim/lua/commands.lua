return function()
    -- Show what kind of syntactic object the cursor is over
    vim.api.nvim_create_user_command('WhatIsThis', [[:echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')]],
        { bang = true, desc = 'show highlight info for word under cursor' }
    )

    -- Open a new split showing all existing color definitions
    vim.api.nvim_create_user_command('ColorMap', ':so $VIMRUNTIME/syntax/hitest.vim',
        { bang = true, desc = 'open color map' }
    )

    -- Save and compile java files
    vim.api.nvim_create_user_command('JavaCompile', 'w | !clear && javac -g %',
        { bang = true, desc = 'complie java file' }
    )

    -- Run current java file
    vim.api.nvim_create_user_command('Java', '!clear && java -ea %:r',
        { bang = true, desc = 'run java file' }
    )

    -- Open the file corresponding to the name under the cursor
    vim.api.nvim_create_user_command('Open', 'normal viWy:vs <C-r>"<CR>',
        { bang = true, desc = 'open file under cursor' }
    )

    -- Move the current buffer into its own tab to the left of the current one
    vim.api.nvim_create_user_command('MoveLeft', 'normal :-1tabnew<CR>,wgt,w:q<CR>gT',
        { bang = true, desc = 'move current buffer left' }
    )

    -- Open a web browser to preview a markdown file
    vim.api.nvim_create_user_command('MarkdownPreview', ':CocCommand markdown-preview-enhanced.openPreview',
        { desc = 'open markdown preview' }
    )
end
