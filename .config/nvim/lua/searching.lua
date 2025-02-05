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

    -- Use <C-/> as a shortcut for :nohlsearch to hide the search highlighting
    vim.keymap.set('n', '<C-/>', function()
        vim.cmd.nohlsearch()
    end, { desc = 'Hide search' })
    -- In some terminals, typing <C-/> actually sends <C-_> to vim for some
    -- reason. So this mapping covers that
    vim.keymap.set('n', '<C-_>', function()
        vim.cmd.nohlsearch()
    end, { desc = 'Hide search 2' })
end
