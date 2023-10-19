-- Remove all autocommands to prevent duplicates on vimrc reload
vim.api.nvim_clear_autocmds({})
-- Disable vi compatibility
vim.opt.compatible = false
-- Use , as the leader key
vim.g.mapleader = ","
-- Use this for WSL default terminal emulator (non wsltty)
-- https://vi.stackexchange.com/questions/28269/command-already-typed-in-when-i-open-vim
--vim.cmd("set t_u7=")

-- =========
-- LAZY.NVIM
-- =========
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
local plugins = {
    -- Visual mode comment/uncomment
    require('plugins.nerdcommenter')(),
    -- File explorer
    require('plugins.nerdtree')(),
    -- Display git branch on statusline
    require('plugins.vim-fugitive')(),
    -- Show vertical lines for indented blocks
    require('plugins.indentline')(),
    -- Highlight trailing whitespace
    require('plugins.vim-better-whitespace')(),
    -- Allows swapping windows with <Leader>w
    require('plugins.vim-windowswap')(),
    -- Better syntax highlighting for python
    require('plugins.python-syntax')(),
    -- Makes the tabline pretty
    require('plugins.taboo')(),
    -- Improve syntax coloring for JSX
    require('plugins.vim-jsx-pretty')(),
    require('plugins.typescript-vim')(),
    require('plugins.vim-jsx-typescript')(),
    -- Syntax highlighting for YANG files
    require('plugins.yang')(),
    -- Syntax highlighting for .jsonc files
    require('plugins.vim-jsonc')(),
    -- Autocomplete and syntax checking
    require('plugins.coc')(),
    -- Autoformatting for python
    require('plugins.black')(),
    -- Syntax highlighting for toml
    require('plugins.vim-toml')(),
    -- Autoformatting for C files
    require('plugins.vim-clang-format')(),
    -- Folding in markdown
    require('plugins.vim-markdown-folding')(),
    -- Utility for editing surrounding symbols like quotes and xml tags
    require('plugins.vim-surround')(),
    -- Allow f, t, F, and T to wrap across lines
    require('plugins.vim-fanfingtastic')(),
    -- Show context of current function
    require('plugins.context')(),
    -- Syntax highlighting for MDX files
    require('plugins.vim-mdx-js')(),
    -- Welcome screen/screensaver
    require('plugins.drop')(),
    -- Tool for moving around the screen more easily
    require('plugins.flash')(),
    -- Installer for language servers
    require('plugins.mason')(),
    -- Connector for language servers
    require('plugins.mason-lspconfig')(),
    -- LSP configuration
    require('plugins.nvim-lspconfig')(),
    -- Status updater for LSP
    require('plugins.fidget')(),
    -- Type hints and such for development of vim itself
    require('plugins.neodev')(),
}
require("lazy").setup(plugins, {})

-- Add package to jump between html tags
vim.cmd('packadd! matchit')


-- ==============
-- Autoformatting
-- ==============
-- Set the auto-formatter for java
--   NOTE: See http://astyle.sourceforge.net/astyle.html for details
vim.api.nvim_create_autocmd({'BufEnter', 'BufRead'}, {pattern = '*.java', command = 'set formatprg=astyle -A1s4SM80m0pHyj'})
-- Make it so that markdown files are formatted properly with gq and also while
-- typing in the file (automatically). See :h fo-table for details.
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {pattern = '*.md', command = 'set formatoptions=tcqln'})
-- Make it so that comments and code are formatted properly with gq in C files
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {pattern = '*.c,*.cpp,*.h,*.hpp,*.js,*.ts,*.jsx,*.tsx', command = 'set formatoptions=croqlj'})
-- Add '/**' to the list of allowable comment block starters. The default
-- setting for this is 'sO:*\ -,mO:*\ ,exO:*/,s1:/*,mb:*,ex:*/,://', so this
-- setting adds the 's1:/**' option to the list to support Doxygen-style
-- comments. See :h comments for details.
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {pattern = '*.c,*.cpp,*.h,*.hpp,*.js,*.ts,*.jsx,*.tsx', command = 'set comments=sO:*\\ -,mO:*\\ ,exO:*/,s1:/**,mb:*,ex:*/,s1:/*,mb:*,ex:*/,://'})

-- ==========
-- Statusline
-- ==========
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

-- ======
-- Colors
-- ======
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

-- ======
-- Typing
-- ======
-- Enable line numbering
vim.opt.nu = true
-- Set length of a tab
vim.opt.tabstop = 4
-- Enable auto indent after return
vim.opt.autoindent = true
-- Enable smarter auto indenting
vim.opt.smartindent = true
-- Use spaces instead of tabs
vim.opt.expandtab = true
-- When using >> to indent, use indent size 4
vim.opt.shiftwidth = 4
-- Allow backspacing over everything in insert mode
vim.opt.backspace = '2'
-- Keep 4 lines above/below cursor
vim.opt.scrolloff = 4
-- Make the backspace key work
vim.opt.backspace = {'indent', 'eol', 'start'}
-- Auto-insert } when typing {<CR> in insert mode
vim.keymap.set('i', '{<CR>', '{<CR><CR>}<ESC>kcc')

-- =====
-- Mouse
-- =====
-- Enable mouse in all modes
vim.opt.mouse = 'a'
-- Hide mouse when typing
vim.cmd('set mousehide')

-- =========
-- Searching
-- =========
-- Ignore case in searches
vim.opt.ignorecase = true
-- Highlight searches
vim.opt.hlsearch = true
-- Show search matches as the search is being typed
vim.opt.incsearch = true
-- Use clc in command mode to clear the search
vim.keymap.set('c', 'clc<CR>', 'let @/ = ""<CR>')
-- Use // in visual mode to search for what is highlighted
vim.keymap.set('v', '//', 'y/<C-R>"<CR>')
-- Make commands apply to all lines (global) by default
vim.opt.gdefault = true
-- Show filepath completion in status line
vim.opt.wildmenu = true
-- Add terms to the current search with + (NOTE: the normal mapping for + is
-- just moving between lines)
vim.keymap.set('n', '+', '/<C-r>/\\|')

-- ============
-- GUI Elements
-- ============
-- Show mode in bottom-left corner
vim.opt.showmode = true
-- Show partial command in bottom right corner
vim.opt.showcmd = true
-- Toggle the ruler on or off
vim.api.nvim_create_user_command('Ruler', 'set colorcolumn=81', {bang = true})
vim.api.nvim_create_user_command('Noruler', 'set colorcolumn=', {bang = true})
-- Resize the window (when not maximized)
vim.keymap.set('n', '<S-Left>', ':set columns-=10<CR>')
vim.keymap.set('n', '<S-Right>', ':set columns+=10<CR>')
vim.keymap.set('n', '<S-Up>', ':set lines-=5<CR>')
vim.keymap.set('n', '<S-Down>', ':set lines+=5<CR>')
-- Show search messages ([X/Y] in bottom right for match X of Y)
vim.cmd('set shortmess-=s')
vim.cmd('set shortmess-=S')
-- Set the cursor for neovim
vim.opt.guicursor = 'n-o-i-c:hor25-blinkwait100-blinkoff500-blinkon500'
-- Make the cursor always a blinking underscore NOTE: add `printf '\033[3 q'` to
-- bashrc to make the cursor work in terminal windows
vim.cmd([[
    let &t_SI .= "\<Esc>[3 q"
    let &t_SR .= "\<Esc>[3 q"
    let &t_EI .= "\<Esc>[3 q"
]])

-- =====
-- NETRW
-- =====
-- Use tree layout by default
vim.g.netrw_liststyle = 3
-- Hide the banner
vim.g.netrw_banner = 0
-- Use default width of 40 columns
vim.g.netrw_winsize = 20
-- Open files in the netrw window
vim.g.netrw_browse_split = 0
-- Use the :Tree command to open netrw in Vim's working directory
vim.api.nvim_create_user_command('Tree', ":execute 'Vexplore' getcwd()", {bang = true, nargs = 0})

-- ===========
-- Performance
-- ===========
-- Helps the screen redraw
vim.opt.ttyfast = true

-- ============
-- Key Mappings
-- ============
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

-- =====
-- Files
-- =====
-- Do not create swap files
vim.opt.swapfile = false
-- Do not create backup files
vim.opt.backup = false
-- Set encoding type
vim.opt.encoding = 'utf-8'
-- Highlight Jenkinsfile as a Groovy script
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {pattern = 'Jenkinsfile', command = 'set filetype=groovy'})
-- Highlight system.config file as JSON
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {pattern = 'system.config', command = 'set filetype=json'})

-- =====================
-- General Configuration
-- =====================
-- Make bash aliases work with external commands
vim.cmd('let $BASH_ENV = "~/.bash_aliases"')
-- Check for external file updates on buffer enter or idle cursor
vim.api.nvim_create_autocmd({'BufEnter'}, {pattern = '*', command = ':checktime'})
vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {pattern = '*', command = 'checktime'})

-- ========
-- Commands
-- ========
-- Show what kind of syntactic object the cursor is over
vim.api.nvim_create_user_command('WhatIsThis', [[:echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')]], {bang = true})
-- Open a new split showing all existing color definitions
vim.api.nvim_create_user_command('ColorMap', ':so $VIMRUNTIME/syntax/hitest.vim', {bang = true})
-- Save and compile java files
vim.api.nvim_create_user_command('JavaCompile', 'w | !clear && javac -g %', {bang = true})
-- Run current java file
vim.api.nvim_create_user_command('Java', '!clear && java -ea %:r', {bang = true})
-- Open the file corresponding to the name under the cursor
vim.api.nvim_create_user_command('Open', 'normal viWy:vs <C-r>"<CR>', {bang = true})
-- Move the current buffer into its own tab to the left of the current one
vim.api.nvim_create_user_command('MoveLeft', 'normal :-1tabnew<CR>,wgt,w:q<CR>gT', {bang = true})
-- Open a web browser to preview a markdown file
vim.api.nvim_create_user_command('MarkdownPreview', ':CocCommand markdown-preview-enhanced.openPreview', {})
