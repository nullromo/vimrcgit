return function()
    -- Use jk to exit insert mode
    vim.keymap.set('i', 'jk', '<ESC>', { desc = 'leave insert mode' })

    -- Move between windows faster
    vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'move to window above' })
    vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'move to window below' })
    vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'move to window left' })
    vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'move to window right' })
    -- Move between terminal windows too
    vim.keymap.set(
        't',
        '<C-k>',
        '<C-w>k',
        { desc = 'move to terminal window above' }
    )
    vim.keymap.set(
        't',
        '<C-j>',
        '<C-w>j',
        { desc = 'move to terminal window below' }
    )
    vim.keymap.set(
        't',
        '<C-h>',
        '<C-w>h',
        { desc = 'move to terminal window left' }
    )
    vim.keymap.set(
        't',
        '<C-l>',
        '<C-w>l',
        { desc = 'move to terminal window right' }
    )
    -- Move around in insert mode faster
    vim.keymap.set('i', '<C-k>', '<C-o>k', { desc = 'move in insert mode up' })
    vim.keymap.set(
        'i',
        '<C-j>',
        '<C-o>j',
        { desc = 'move in insert mode down' }
    )
    vim.keymap.set(
        'i',
        '<C-h>',
        -- need to use <C-\> here because if you use this mapping from the last
        -- position in the line, it will move 2 characters to the left
        '<C-\\><C-o>h',
        { desc = 'move in insert mode left' }
    )
    vim.keymap.set('i', '<C-l>', function()
        local currentColumn = vim.fn.col('.')
        local maxColumn = vim.fn.strlen(vim.fn.getline('.'))
        -- if at the end of the line, <C-o>l will not be able to move 1 position
        -- forward. TODO: would be nice to be able to do this without leaving
        -- insert mode for the purposes of the . command
        if currentColumn >= maxColumn then
            return '<ESC>A'
        else
            return '<C-o>l'
        end
    end, { expr = true, desc = 'move in insert mode right' })
    vim.keymap.set('i', '<C-/>', function()
        return require('util').motionFromInsertMode('n')
    end, { expr = true, desc = 'next search match in insert mode' })
    vim.keymap.set('i', '<C-S-n>', function()
        return require('util').motionFromInsertMode('N')
    end, { expr = true, desc = 'previous search match in insert mode' })

    -- Use ; for command mode
    vim.keymap.set({ 'n', 'v' }, ';', ':', { desc = 'enter ex mode' })
    -- Use ; for command mode in terminal windows
    vim.keymap.set(
        't',
        ';',
        '<C-w>:',
        { desc = 'enter ex mode in terminal window' }
    )
    -- Use <C-;> to get an actual ; in a terminal window
    vim.keymap.set('t', '<C-;>', ';', { desc = 'type ; in terminal window' })

    -- Use <C-z> to send vim to the background from terminal windows
    vim.keymap.set(
        't',
        '<C-z>',
        '<C-w>:suspend<CR>',
        { desc = 'suspend vim from terminal window' }
    )

    -- Use gt and gT to go to tabs from within terminal windows
    vim.keymap.set(
        't',
        'gt',
        '<C-w>gt',
        { desc = 'next tab in terminal window' }
    )
    vim.keymap.set(
        't',
        'gT',
        '<C-w>gT',
        { desc = 'previous tab in terminal window' }
    )

    -- Use <C-'> to paste in terminal windows
    vim.keymap.set(
        't',
        "<C-'>",
        '<C-w>""',
        { desc = 'paste in terminal window' }
    )

    -- Use <C-w><C-w> to enter terminal normal mode
    vim.keymap.set(
        't',
        '<C-w><C-w>',
        '<C-w>N',
        { desc = 'enter terminal normal mode' }
    )

    -- Move along rows instead of lines (for lines that wrap around). The 0, ^,
    -- and $ versions also swap the g- prefixed commands so that they are
    -- accessible if necessary
    vim.keymap.set('n', 'j', 'gj', { desc = 'move down within line wrap' })
    vim.keymap.set('n', 'k', 'gk', { desc = 'move up within line wrap' })
    -- Function for handling 0, ^, and $. The motion argument can be 0, ^, or $.
    -- The g argument can be true or false, and it signifies whether or not g
    -- was pressed before the motion
    local lineJumpMotion = function(motion, g)
        -- if wrap is on, then we want to switch the motion and g-motion
        -- commands. This means the non-g actions to move to the visible
        -- starts/ends of lines
        if vim.opt.wrap:get() then
            if g then
                vim.cmd('normal! ' .. motion)
            else
                vim.cmd('normal! g' .. motion)
            end
        -- if wrap is off, then we want to keep the default motion vs. g-motion
        -- behavior. This means the non-g actions move the the actual
        -- starts/ends of lines
        else
            if g then
                vim.cmd('normal! g' .. motion)
            else
                vim.cmd('normal! ' .. motion)
            end
        end
    end
    vim.keymap.set('n', '0', function()
        lineJumpMotion('0', false)
    end, { desc = 'jump to beginning of line within line wrap' })
    vim.keymap.set('n', 'g0', function()
        lineJumpMotion('0', true)
    end, { desc = 'jump to beginning of line across line wrap' })
    vim.keymap.set('n', '^', function()
        lineJumpMotion('^', false)
    end, { desc = 'jump to beginning of text within line wrap' })
    vim.keymap.set('n', 'g^', function()
        lineJumpMotion('^', true)
    end, { desc = 'jump to beginning of text across line wrap' })
    vim.keymap.set('n', '$', function()
        lineJumpMotion('$', false)
    end, { desc = 'jump to end of line within line wrap' })
    vim.keymap.set('n', 'g$', function()
        lineJumpMotion('$', true)
    end, { desc = 'jump to end of line across line wrap' })

    -- Use space to center the screen
    vim.keymap.set(
        { 'n', 'v' },
        '<space>',
        'zz',
        { desc = 'center the screen' }
    )

    -- Use , + direction to resize windows
    vim.keymap.set(
        'n',
        '<Leader>h',
        ':vertical resize +3<CR>',
        { desc = 'window size increase horizontally' }
    )
    vim.keymap.set(
        'n',
        '<Leader>j',
        ':resize +3<CR>',
        { desc = 'window size increase vertically' }
    )
    vim.keymap.set(
        'n',
        '<Leader>k',
        ':resize -3<CR>',
        { desc = 'window size decrease vertically' }
    )
    vim.keymap.set(
        'n',
        '<Leader>l',
        ':vertical resize -3<CR>',
        { desc = 'window size decrease horizontally' }
    )

    -- Normally <C-w>| and <C-w>_ maximize windows. Use <C-w>- and <C-w>\ to minimize
    vim.keymap.set('n', '<C-w>-', ':resize 0<CR>', { desc = 'minimize window' })
    vim.keymap.set(
        'n',
        '<C-w>\\',
        ':vertical resize 0<CR>',
        { desc = 'maximize window' }
    )

    -- Allow for accidental capital letters when saving or quitting. Command
    -- mode applies to both : commands and / commands, so check the cmdtype
    -- first
    vim.keymap.set(
        'c',
        'W<CR>',
        "getcmdtype() =~ '^[:]$' ? 'w<CR>' : 'W<CR>'",
        { expr = true, desc = 'save file with W' }
    )
    vim.keymap.set(
        'c',
        'X<CR>',
        "getcmdtype() =~ '^[:]$' ? 'x<CR>' : 'X<CR>'",
        { expr = true, desc = 'quit with X' }
    )

    -- Use :Q for :cquit. Sometimes you might want vim to exit with a non-zero
    -- exit code (for example, you are using vimdiff and you don't want to save
    -- any changes). In this case, you can use :cq.
    vim.keymap.set(
        'c',
        'Q<CR>',
        "getcmdtype() =~ '^[:]$' ? 'cquit<CR>' : 'Q<CR>'",
        { expr = true, desc = 'close file with Q' }
    )

    -- Custom function for scrolling 1/4 of the screen
    vim.cmd([[
        function! ScrollQuarter(move) abort
            let height = winheight(0)
            if a:move == 'up'
                let scrollKey = "\<C-Y>"
                let motionKey = "k"
            elseif a:move == 'down'
                let scrollKey = "\<C-E>"
                let motionKey = "j"
            else
                let scrollKey = ""
                let motionKey = ""
            endif
            execute 'normal! ' . height/4 . scrollKey
            execute 'normal! ' . height/4 . motionKey
        endfunction
        " Remap <C-u> and <C-d> to move using the custom function
        nnoremap <silent> <C-U> :call ScrollQuarter('up')<CR>
        nnoremap <silent> <C-D> :call ScrollQuarter('down')<CR>
    ]])
    local ScrollSidewaysChunk = function(move)
        local amount = math.floor(vim.fn.winwidth(0) / 8)
        if move == 'left' then
            vim.cmd('normal! ' .. amount .. 'zh')
        elseif move == 'right' then
            vim.cmd('normal! ' .. amount .. 'zl')
        end
    end
    vim.keymap.set('n', '<S-h>', function()
        ScrollSidewaysChunk('left')
    end, { desc = '' })
    vim.keymap.set('n', '<S-l>', function()
        ScrollSidewaysChunk('right')
    end, { desc = '' })

    -- Printline shortcuts
    vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = 'java',
        callback = function()
            vim.keymap.set(
                'i',
                'sout<TAB>',
                'System.out.println("");<ESC>2hi',
                { buffer = 0 }
            )
        end,
        desc = 'java println',
    })
    vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = 'c,cpp',
        callback = function()
            vim.keymap.set(
                'i',
                'serr<TAB>',
                'fprintf(stderr, "\\n");<ESC>4hi',
                { buffer = 0 }
            )
            vim.keymap.set(
                'i',
                'sout<TAB>',
                'printf("\\n");<ESC>4hi',
                { buffer = 0 }
            )
            vim.keymap.set(
                'i',
                'clog<TAB>',
                'printf("\\n");<ESC>4hi',
                { buffer = 0 }
            )
        end,
        desc = 'c println',
    })
    vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = 'javascript,typescript,javascriptreact,typescriptreact',
        command = 'inoremap <buffer> clog<TAB> console.log();<Left><Left>',
        desc = 'javascript println clog',
    })
    vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = 'javascript,typescript,javascriptreact,typescriptreact',
        command = 'inoremap <buffer> sout<TAB> console.log();<Left><Left>',
        desc = 'javascript println sout',
    })

    -- Close all windows in a tab using qt
    vim.keymap.set('c', 'qt<CR>', function()
        -- exit command mode and close the current tab
        local tabCloseOK, result = pcall(function()
            vim.api.nvim_feedkeys(
                vim.api.nvim_replace_termcodes('<ESC>', true, false, true),
                'n',
                false
            )
            return vim.cmd('tabclose')
        end)
        -- if closing the current tab failed and the resulting error message complains about the tab being the last tab, exit vim
        if
            not tabCloseOK and string.find(result, 'Cannot close last tab page')
        then
            vim.print('Closing last tab page by exiting vim')
            vim.cmd('qa')
        end
    end, { desc = 'close tab' })

    -- Open a new tab with ,t
    vim.keymap.set('n', '<leader>t', ':tabnew<CR>', { desc = 'new tab' })

    -- Open a terminal in a vertial split
    vim.keymap.set(
        'c',
        'vt',
        'vertical terminal',
        { desc = 'open vertical terminal' }
    )

    -- Disable default Ex mode mapping
    vim.keymap.set('n', 'Q', '<nop>', { desc = 'disable Q' })

    -- Use <C-c> to copy selection to the system clipboard
    vim.keymap.set(
        'v',
        '<C-c>',
        [[y:!echo <C-r>=escape(substitute(shellescape(getreg('"')), '\n', '\r', 'g'), '#%!')<CR> <Bar> clip.exe<CR><CR>]],
        { desc = 'copy to system clipboard' }
    )

    -- Add shortcuts for typing arrow functions in JavaScript and TypeScript
    vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = 'javascript,typescript,javascriptreact,typescriptreact',
        command = 'inoremap <C-=> () => {<CR>.<CR>}<ESC>kA<backspace>',
        desc = 'insert arrow function',
    })
    vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = 'javascript,typescript,javascriptreact,typescriptreact',
        command = 'inoremap <C-0> ) => {<CR>.<CR>})<ESC>kA<backspace>',
        desc = 'insert arrow function with close',
    })

    -- Switch p and P in visual mode
    vim.keymap.set('x', 'p', 'P', { desc = 'switch p and P' })
    vim.keymap.set('x', 'P', 'p', { desc = 'switch P and p' })

    -- Open help windows to the left by default without having to use :vertical
    vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = 'help',
        command = 'wincmd H',
        desc = 'open help windows to the left',
    })

    -- Go to end of line NOT including the newline character
    vim.keymap.set(
        'v',
        '$',
        'g_',
        { desc = 'do not include newline at end of line' }
    )
end
