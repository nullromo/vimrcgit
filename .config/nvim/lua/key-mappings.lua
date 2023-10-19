return function()
    -- Use jk to exit insert mode
    vim.keymap.set('i', 'jk', '<ESC>')
    -- Move between windows faster
    vim.keymap.set('n', '<C-k>', '<C-w>k')
    vim.keymap.set('n', '<C-j>', '<C-w>j')
    vim.keymap.set('n', '<C-h>', '<C-w>h')
    vim.keymap.set('n', '<C-l>', '<C-w>l')
    -- Move between terminal windows too
    vim.keymap.set('t', '<C-k>', '<C-w>k')
    vim.keymap.set('t', '<C-j>', '<C-w>j')
    vim.keymap.set('t', '<C-h>', '<C-w>h')
    vim.keymap.set('t', '<C-l>', '<C-w>l')
    -- Move around in insert mode faster
    vim.keymap.set('i', '<C-k>', '<C-o>k')
    vim.keymap.set('i', '<C-j>', '<C-o>j')
    vim.keymap.set('i', '<C-h>', '<C-o>h')
    vim.keymap.set('i', '<C-l>', '<C-o>l')
    -- Use ; for command mode
    vim.keymap.set('n', ';', ':')
    -- Use ; for command mode in terminal windows
    vim.keymap.set('t', ';', '<C-w>:')
    -- Use <C-;> to get an actual ; in a terminal window
    vim.keymap.set('t', '<C-;>', ';')
    -- Use <C-z> to send vim to the background from terminal windows
    vim.keymap.set('t', '<C-z>', '<C-w>:suspend<CR>')
    -- Use gt and gT to go to tabs from within terminal windows
    vim.keymap.set('t', 'gt', '<C-w>gt')
    vim.keymap.set('t', 'gT', '<C-w>gT')
    -- Use <C-'> to paste in terminal windows
    vim.keymap.set('t', "<C-'>", '<C-w>""')
    -- Use <C-w><C-w> to enter terminal normal mode
    vim.keymap.set('t', '<C-w><C-w>', '<C-w>N')
    -- Move along rows instead of lines (for lines that wrap around)
    vim.keymap.set('n', 'j', 'gj')
    vim.keymap.set('n', 'k', 'gk')
    vim.keymap.set('n', '0', 'g0')
    vim.keymap.set('n', '^', 'g^')
    vim.keymap.set('n', '$', 'g$')
    -- Use space to center the screen
    vim.keymap.set({'n', 'v'}, '<space>', 'zz')
    -- Center the screen after searching
    vim.keymap.set('n', 'n', 'nzzlN')
    vim.keymap.set('n', 'N', 'NzzlN')
    vim.keymap.set('n', '*', '*zzlN')
    vim.keymap.set('n', '#', '#zzlN')
    -- When using *, just start the search without going to the next match
    vim.keymap.set('n', '*', '*N')
    -- Use , + direction to resize windows
    vim.keymap.set('n', '<Leader>h', ':vertical resize +3<CR>')
    vim.keymap.set('n', '<Leader>j', ':resize +3<CR>')
    vim.keymap.set('n', '<Leader>k', ':resize -3<CR>')
    vim.keymap.set('n', '<Leader>l', ':vertical resize -3<CR>')
    -- Normally <C-w>| and <C-w>_ maximize windows. Use <C-w>- and <C-w>\ to minimize
    vim.keymap.set('n', '<C-w>-', ':resize 0<CR>')
    vim.keymap.set('n', '<C-w>\\', ':vertical resize 0<CR>')
    -- Select current block from visual mode
    vim.keymap.set('v', 'i}', '<ESC>{jV}k')
    vim.keymap.set('v', 'i{', '<ESC>{jV}k')
    -- Add an alias for the scriptnames command
    vim.keymap.set('c', 'scripts<CR>', 'scriptnames<CR>')
    -- Allow for accidental capital letters when saving or quitting
    vim.keymap.set('c', 'W<CR>', "getcmdtype() =~ '^[:]$' ? 'w<CR>' : 'W<CR>'", {expr = true})
    vim.keymap.set('c', 'X<CR>', "getcmdtype() =~ '^[:]$' ? 'x<CR>' : 'X<CR>'", {expr = true})
    vim.keymap.set('c', 'Q<CR>', "getcmdtype() =~ '^[:]$' ? 'q<CR>' : 'Q<CR>'", {expr = true})
    -- Custom function for scrolling 1/4 of the screen
    vim.cmd([[
        function ScrollQuarter(move) abort
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
    -- Printline shortcuts
    vim.api.nvim_create_autocmd({'FileType'}, {pattern = 'java', callback =
        function()
            vim.keymap.set('i', 'sout<TAB>', 'System.out.println("");<ESC>2hi', {buffer = 0})
        end
    })
    vim.api.nvim_create_autocmd({'FileType'}, {pattern = 'c,cpp', callback =
        function()
            vim.keymap.set('i', 'serr<TAB>', 'fprintf(stderr, "\\n");<ESC>4hi', {buffer = 0})
            vim.keymap.set('i', 'sout<TAB>', 'printf("\\n");<ESC>4hi', {buffer = 0})
            vim.keymap.set('i', 'clog<TAB>', 'printf("\\n");<ESC>4hi', {buffer = 0})
        end
    })
    vim.api.nvim_create_autocmd({'FileType'}, {pattern = 'javascript,typescript,javascriptreact,typescriptreact', command = 'inoremap <buffer> clog<TAB> console.log();<ESC>hi'})
    vim.api.nvim_create_autocmd({'FileType'}, {pattern = 'javascript,typescript,javascriptreact,typescriptreact', command = 'inoremap <buffer> sout<TAB> console.log();<ESC>hi'})
    -- Close all windows in a tab using qt
    vim.keymap.set('c', 'qt<CR>', 'tabclose<CR>')
    -- Open a terminal in a vertial split
    vim.keymap.set('c', 'vt', 'vertical terminal')
    -- Disable default Ex mode mapping
    vim.keymap.set('n', 'Q', '<nop>')
    -- Use C-c to copy selection to the system clipboard
    vim.keymap.set('v', '<C-c>', [[y:!echo <C-r>=escape(substitute(shellescape(getreg('"')), '\n', '\r', 'g'), '#%!')<CR> <Bar> clip.exe<CR><CR>]])
    -- Add shortcuts for typing arrow functions in JavaScript and TypeScript
    vim.api.nvim_create_autocmd({'FileType'}, {pattern = 'javascript,typescript,javascriptreact,typescriptreact', command = 'inoremap <C-=> () => {<CR>.<CR>}<ESC>kA<backspace>'})
    vim.api.nvim_create_autocmd({'FileType'}, {pattern = 'javascript,typescript,javascriptreact,typescriptreact', command = 'inoremap <C-0> ) => {<CR>.<CR>})<ESC>kA<backspace>'})
end
