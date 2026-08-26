return function()
    -- Custom statusline generation function
    function MakeStatusLine()
        -- True if the window is selected
        local focused = vim.g.statusline_winid
            == vim.fn.win_getid(vim.fn.winnr())
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
        statusline = statusline
            .. '%( '
            .. branchNameColor
            .. "%{get(b:,'gitsigns_status_dict','')['head']}%*%)"
        statusline = statusline .. ' '
        -- Add the folder path and truncate it from the left if necessary
        statusline = statusline .. '%<' .. "%{expand('%:~:h')}/"
        -- Add file name
        statusline = statusline .. fileNameColor .. '%t%*'
        -- Add modified flag
        statusline = statusline .. ' %m'
        -- Add spacer
        statusline = statusline .. '%='
        -- Add the cash.nvim indicator in the focused window only.
        local cashLoaded, cash = pcall(require, 'cash')
        if focused and cashLoaded and cash.opts ~= nil then
            statusline = statusline
                .. ' '
                .. cash.statusline({
                    brackets = 'angle',
                    display = 'number',
                    style = 'current',
                })
                .. ' '
        end
        -- Add location within file
        statusline = statusline
            .. '%(line '
            .. numberColor
            .. '%l%* of '
            .. numberColor
            .. '%L%*'
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
