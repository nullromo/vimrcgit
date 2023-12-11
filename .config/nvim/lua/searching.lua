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
    vim.keymap.set('n', '+', '/<C-r>/\\|')
    -- Center the screen after searching
    vim.keymap.set('n', 'n', 'nzz')
    vim.keymap.set('n', 'N', 'Nzz')

    -- color constants
    local sumiInk0 = '#16161D'
    local fujiWhite = '#DCD7BA'
    local roninYellow = '#FF9E3B'
    local springBlue = '#7FB4CA'
    local sakuraPink = '#D27E99'
    local springGreen = '#98BB6C'
    local autumnYellow = '#DCA561'
    local oniViolet = '#957FB8'
    local autumnGreen = '#76946A'
    local autumnRed = '#C34043'
    local waveBlue2 = '#2D4F67'

    -- define colors for highlight groups
    local searchHighlightColors = {
        { bg = roninYellow },
        { bg = springBlue },
        { bg = sakuraPink },
        { bg = springGreen },
        { bg = autumnYellow },
        { bg = oniViolet },
        { bg = autumnGreen },
        { bg = autumnRed },
        { bg = waveBlue2, fg = fujiWhite },
    }

    -- set up highlight groups
    for i = 1, 9 do
        vim.cmd.highlight(
            'SearchPattern' .. i,
            'guibg=' .. searchHighlightColors[i].bg  .. ' guifg=' .. (searchHighlightColors[i].fg or sumiInk0)
        )
    end

    -- debug
    --vim.fn.matchadd('SearchPattern1', 'SearchPattern1', -1)
    --vim.fn.matchadd('SearchPattern2', 'SearchPattern2', -1)
    --vim.fn.matchadd('SearchPattern3', 'SearchPattern3', -1)
    --vim.fn.matchadd('SearchPattern4', 'SearchPattern4', -1)
    --vim.fn.matchadd('SearchPattern5', 'SearchPattern5', -1)
    --vim.fn.matchadd('SearchPattern6', 'SearchPattern6', -1)
    --vim.fn.matchadd('SearchPattern7', 'SearchPattern7', -1)
    --vim.fn.matchadd('SearchPattern8', 'SearchPattern8', -1)
    --vim.fn.matchadd('SearchPattern9', 'SearchPattern9', -1)

    -- initialize search highlighting globals
    local currentSearchHighlightIndex
    local searchHighlightPatterns
    local matchIDs

    -- sets the given string as the search pattern for the current index
    local setSearch = function(searchString)
        if searchString == '' then
            vim.fn.setreg('/', '')
        end
        searchHighlightPatterns[currentSearchHighlightIndex] = searchString
    end

    -- set up initial values for saved search pattern state
    local initializeSearchPatterns = function()
        currentSearchHighlightIndex = 1
        searchHighlightPatterns = { '', '', '', '', '', '', '', '', '' }
        matchIDs = { nil, nil, nil, nil, nil, nil, nil, nil, nil }
        setSearch('')
    end

    -- initialize search pattern state
    initializeSearchPatterns()

    -- print debug info
    local printDebugInfo = function()
        local s = ''
        for i = 1, 9 do
            local x = searchHighlightPatterns[i]
            if x == nil then
                s = s .. 'nil' .. ', '
            else
                s = s .. x .. ', '
            end
        end
        local z = ''
        for i = 1, 9 do
            local x = matchIDs[i]
            if x == nil then
                z = z .. 'nil' .. ', '
            else
                z = z .. x .. ', '
            end
        end
        vim.notify('index: ' .. currentSearchHighlightIndex .. ' table: ' .. s .. ' : ' .. z)
    end

    -- use <Leader>v to print debug info
    vim.keymap.set('n', '<Leader>v', function()
        printDebugInfo()
    end)

    local setSearchIndex = function(newIndex)
        -- get the saved search pattern for the selected index
        local searchPattern = searchHighlightPatterns[newIndex]

        -- delete the match that was highlighting the newIndex-th pattern
        if matchIDs[newIndex] ~= nil and matchIDs[newIndex] ~= -1 then
            vim.fn.matchdelete(matchIDs[newIndex])
            matchIDs[newIndex] = nil
        end

        -- add a match for the old search highlight
        matchIDs[currentSearchHighlightIndex] = vim.fn.matchadd(
            'SearchPattern' .. currentSearchHighlightIndex,
            searchHighlightPatterns[currentSearchHighlightIndex]
        )

        -- change the active search highlight color
        vim.api.nvim_set_hl(0, 'Search', {
            fg = searchHighlightColors[newIndex].fg or sumiInk0,
            bg = searchHighlightColors[newIndex].bg,
        })

        -- if there is no search pattern, use an empty string
        if searchPattern == nil or searchPattern == '' then
            -- clear the search register
            vim.fn.setreg('/', {})
        else
            -- store saved highlight pattern in search register
            vim.fn.setreg('/', searchPattern)
            -- search for the highlighted pattern
            vim.fn.search(searchPattern, 'w')
        end

        -- set the global search highlight index
        currentSearchHighlightIndex = newIndex
    end

    -- use ?<number> to swap to the <number>-th search pattern
    vim.keymap.set('n', '?', function()
        -- get a character from the user
        local userNumber = tonumber(vim.fn.nr2char(vim.fn.getchar()))

        -- if the user didn't enter a number, do nothing
        if userNumber == nil then
            return
        end

        -- set the search pattern index to the user's desired number
        setSearchIndex(userNumber)
    end)

    -- run custom function after searching from the command line
    vim.keymap.set('c', '<CR>',
        function()
            -- check if the current command is a search command
            local commandType = vim.fn.getcmdtype()
            if commandType == '/' or commandType == '?' then
                setSearch(vim.fn.getcmdline())
            end

            -- execute the command as normal
            return '<CR>'
        end,
        { expr = true }
    )

    -- run custom function after searching with * or #
    vim.keymap.set('n', '*',
        function()
            -- set the search pattern as * normally would
            setSearch(vim.fn.expand('<cword>'))

            -- if a count was supplied, execute * normally and exit
            if vim.v.count > 0 then
                vim.cmd('normal! ' .. vim.v.count .. '*<CR>')
            else
                -- save current window view
                local windowView = vim.fn.winsaveview()

                -- execute * normally
                vim.cmd('silent keepjumps normal! *<CR>')

                -- restore the window view
                if windowView ~= nil then
                    vim.fn.winrestview(windowView)
                end
            end

            -- center the screen
            vim.cmd('normal! zz<CR>')
        end
    )
    vim.keymap.set('n', '#',
        function()
            -- set the search pattern as # normally would
            setSearch(vim.fn.expand('<cword>'))

            -- execute # normally
            return '#zz'
        end,
        { expr = true }
    )

    -- Use // in visual mode to search for what is highlighted. Also integrate with custom function
    vim.keymap.set(
        'v',
        '//',
        function()
            -- set the search pattern to what was in the selection
            setSearch(vim.fn.expand('<cword>'))

            -- 1. yank the selected text (y)
            -- 2. begin a search and set very nomagic (/\V)
            -- 3. enter the contents of the expression register (<C-r>=)
            -- 4. escape slashes and backslashes from the contents of the " register (escape(@", '/\')<CR>)
            -- 5. enter the search (<CR>)
            return 'y/\\V<C-r>=escape(@",\'/\\\')<CR><CR>'
        end,
        { expr = true }
    )

    -- Use clc in command mode to clear the search
    vim.keymap.set(
        'c',
        'clc<CR>',
        function()
            -- check if the command was entered in the ex command line
            local commandType = vim.fn.getcmdtype()
            if commandType == ':' then
                -- search for nothing
                setSearch('')
                -- clear the current search highlight
                --return 'noh<CR>'
                return '<CR>'
            end
            if commandType == '/' or commandType == '?' then
                setSearch('clc')
            end

            -- otherwise, don't change any behavior
            return 'clc<CR>'
        end,
        { expr = true }
    )

    -- function to clear all searches and start back at index 1
    vim.api.nvim_create_user_command('ClearSearches',
        function()
            -- clear current search
            setSearch('')

            -- reset search index to 1
            setSearchIndex(1)

            -- remove all leftover match highlights
            for i = 1, 9 do
                if matchIDs[i] ~= nil and matchIDs[i] ~= -1 then
                    vim.fn.matchdelete(matchIDs[i])
                    matchIDs[i] = nil
                end
            end

            -- re-initialize state for saved search patterns
            initializeSearchPatterns()
        end,
        { bang = true }
    )
end
