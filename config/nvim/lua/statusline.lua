return function()
    -- Custom statusline generation function
    function MakeStatusLine()
        -- True if the window is selected
        local focused = vim.g.statusline_winid == vim.fn.win_getid(vim.fn.winnr())
        -- Build the statusline
        local statusline = ''

        -- Color helper strings
        local colorNC = focused and '' or 'NC'
        local fileNameColor = '%#StatusLineFileName' .. colorNC .. '#'
        local metaColor = '%#StatusLineMeta' .. colorNC .. '#'
        local numberColor = '%#StatusLineNumber' .. colorNC .. '#'
        local percentColor = '%#StatusLinePercent' .. colorNC .. '#'
        local branchNameColor = '%#StatusLineGitBranchName' .. colorNC .. '#'
        -- Add the buffer number
        statusline = statusline .. metaColor .. '%n%*'
        -- Add the current git branch name
        --   NOTE: there is an issue here. The statusline is updated both when entering and exiting a buffer. This means that the
        --   call to fugitive#head() will set both the switched-from and switched-to buffer's status lines to have the branch of
        --   the switched-to buffer.
        local notInGit = vim.fn.len(vim.fn.FugitiveHead()) == 0
        statusline = statusline .. ' ' .. (notInGit and '' or (branchNameColor .. '%{FugitiveHead()}%* '))
        -- Add the folder path
        statusline = statusline .. "%{expand('%:~:h')}/"
        -- Add file name
        statusline = statusline .. fileNameColor .. '%t%*'
        -- Add modified flag
        statusline = statusline .. ' %m'
        -- Add spacer
        statusline = statusline .. '%='
        -- Add location within file
        statusline = statusline .. '%(line ' .. numberColor .. '%l%* of ' .. numberColor .. '%L%*'
        statusline = statusline .. ' [' .. percentColor .. '%p%%%*]'
        statusline = statusline .. ' col ' .. numberColor .. '%c%*%)'
        -- Add vim file type
        statusline = statusline .. ' ' .. metaColor .. '%y'
        return statusline
    end
    -- Set the statusline to the output of the custom function
    vim.opt.statusline = '%!v:lua.MakeStatusLine()'
    -- Make sure there is always a statusline at the very bottom window
    vim.opt.laststatus = 2
end
