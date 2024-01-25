return function()
    -- Ignore case in searches
    vim.opt.ignorecase = true

    -- Highlight searches
    vim.opt.hlsearch = true

    -- Show search matches as the search is being typed
    vim.opt.incsearch = true

    -- Make commands apply to all lines (global) by default
    vim.opt.gdefault = true

    -- Show filepath completion in status line
    vim.opt.wildmenu = true

    -- Add terms to the current search with + (NOTE: the normal mapping for + is
    -- just moving between lines)
    vim.keymap.set('n', '+', '/<C-r>/\\|', { desc = 'add to current search' })

    -- Center the screen after searching
    vim.keymap.set(
        'n',
        'n',
        'nzz',
        { desc = 'center screen after searching forward' }
    )
    vim.keymap.set(
        'n',
        'N',
        'Nzz',
        { desc = 'center screen after searching backward' }
    )

    -- Use // in visual mode to search for what is highlighted. Also integrate
    -- with custom function
    vim.keymap.set('v', '//', function()
        -- set the search pattern to what was in the selection
        require('cash').setSearch(vim.fn.expand('<cword>'))

        -- 1. yank the selected text (y)
        -- 2. begin a search and set very nomagic (/\V)
        -- 3. enter the contents of the expression register (<C-r>=)
        -- 4. escape slashes and backslashes from the contents of the "
        --    register (escape(@", '/\')<CR>)
        -- 5. enter the search (<CR>)
        return "y/\\V<C-r>=escape(@\",'/\\')<CR><CR>"
    end, { expr = true, desc = 'search for visual selection' })
end
