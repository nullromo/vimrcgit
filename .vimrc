" Remove all autocommands to prevent duplicates on vimrc reload
autocmd!
" Disable vi-compatibility
set nocompatible
" Use , as the leader key
let mapleader=","
" Use this for WSL default terminal emulator (non wsltty)
" https://vi.stackexchange.com/questions/28269/command-already-typed-in-when-i-open-vim
"set t_u7=

" ========
" VIM-PLUG
" ========
" Download vim-plug itself if it doesn't exist
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" Install plugins
call plug#begin('~/.vim/plugged')
" Use tab for autocomplete
Plug 'ervandew/supertab'
" Syntax checker
"Plug 'vim-syntastic/syntastic'
" Visual mode comment/uncomment
Plug 'preservim/nerdcommenter'
" File explorer
Plug 'preservim/nerdtree'
" Display git branch on statusline
Plug 'tpope/vim-fugitive'
" Show vertical lines for indented blocks
Plug 'yggdroot/indentline'
" Highlight trailing whitespace
Plug 'ntpeters/vim-better-whitespace'
" Allows swapping windows with <Leader>w
Plug 'wesQ3/vim-windowswap'
" Better syntax highlighting for python
Plug 'vim-python/python-syntax'
" Makes the tabline pretty
Plug 'gcmt/taboo.vim'
" Improve syntax coloring for JSX
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
"Plug 'othree/yajs'
"Plug 'HerringtonDarkholme/yats.vim'
"Plug 'pangloss/vim-javascript'
" Syntax highlighting for YANG files
Plug 'nathanalderson/yang.vim'
" Syntax highlighting for .jsonc files
Plug 'kevinoid/vim-jsonc'
" Autocomplete and syntax checking
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"Plug 'majutsushi/tagbar' " cnoremap tt<CR> TagbarToggle<CR>
"Plug 'pangloss/vim-javascript'

" Autoformatting for python
Plug 'psf/black'
" Syntax highlighting for toml
Plug 'cespare/vim-toml'
" Autoformatting for C files
Plug 'rhysd/vim-clang-format'
call plug#end()

" =========
" SYNTASTIC
" =========
" Set C++ compiler and options
let g:syntastic_cpp_compiler = "g++"
let g:syntastic_cpp_compiler_options = "-std=c++11"
" Always put errors from syntastic into the location list
let g:syntastic_always_populate_loc_list = 1
" Automatically open/close the location list
let g:syntastic_auto_loc_list = 1
" Check syntax when file is opened
let g:syntastic_check_on_open = 1
" Don't check syntax when closing a file (wq, x, or ZZ)
let g:syntastic_check_on_wq = 0
" Set syntastic JS checker to eslint and use eslint daemon
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'

" ==============
" NERD COMMENTER
" ==============
" Use c/u to comment/uncomment the selection in visual mode
vnoremap c :call nerdcommenter#Comment('n', 'Comment')<CR>
vnoremap u :call nerdcommenter#Comment('n', 'Uncomment')<CR>

" ========
" NERDTREE
" ========
" Close NERDTree when a file is opened
let NERDTreeQuitOnOpen=1
" Do not show bookmarks
let NERDTreeShowBookmarks=0
" Show files and hidden files in NREDTree
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
" Show line numbers in NERDTree
let NERDTreeShowLineNumbers=1

" ==========
" INDENTLINE
" ==========
" Set the color
let g:indentLine_color_term = 'brown'
" Set the character
let g:indentLine_char = '|'
" Do not use in json or help files
"   NOTE: since this plugin uses vim's conceal feature, and that messes up
"   JSON quotes, it doens't really work in json files
let g:indentLine_fileTypeExclude = ['json', 'jsonc', 'help']

" ===========
" WINDOW SWAP
" ===========
" Prevent default bindings
let g:windowswap_map_keys = 0
" Use ,w to 'yank' and 'paste' windows
nnoremap <silent> <Leader>w :call WindowSwap#EasyWindowSwap()<CR>

" =============
" PYTHON-SYNTAX
" =============
" Turn on all highlighting
let g:python_highlight_all = 1

" =====
" TABOO
" =====
" Allows tab names to be saved in the session file
set sessionoptions+=tabpages,globals
" Set the tab format for default tabs
let g:taboo_tab_format = '├%N%U╯%f %m'
" Set the tab format for renamed tabs
let g:taboo_renamed_tab_format = '├%N%U╯%l %m'
" Put a clock in the top-right corner of the tabline
let g:taboo_close_tabs_label = "%{strftime('%a\ %e\ %b\ %I:%M:%S\ %p')}"
" Always show the tabline
set showtabline=2

" ===
" COC
" ===
" Install CoC extensions when the service starts
let g:coc_global_extensions = ['coc-tsserver', 'coc-json', 'coc-html', 'coc-css', 'coc-pyright', 'coc-git', 'coc-prettier', 'coc-eslint', 'coc-clangd']
" Use <tab> to trigger completion/navigate to the next item
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
endfunction
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<Tab>" : coc#refresh()
" Navigate the completion list with control + j/k in addition to control + n/p
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
" Move between errors
nmap <silent> [[ <Plug>(coc-diagnostic-prev)
nmap <silent> ]] <Plug>(coc-diagnostic-next)
" Allow the [[ and ]] to work in python
let g:no_python_maps = 1
" Use :Check to get errors current buffer in location list
command! Check :CocDiagnostics()<CR>
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K for hover-style documentation/help
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " .
        expand('<cword>')
    endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>
" Add command for organizing imports
command! -nargs=0 OrganizeImports :call CocAction('runCommand', 'editor.action.organizeImport')
" Shortcut for perttier to format javascript/css
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" Shortcut for CocAction
command! Ca CocAction
" Shortcut for switching to C header files
command! GHeader CocCommand clangd.switchSourceHeader
command! Header rightbelow sp | CocCommand clangd.switchSourceHeader
command! VHeader rightbelow vsp | CocCommand clangd.switchSourceHeader

" =====
" BLACK
" =====
autocmd BufWritePre *.py execute ':Black'
" This does not do anything (yet)
let g:black_skip_magic_trailing_comma = 1

" ================
" VIM-CLANG-FORMAT
" ================
" Set options for clang-format in case there is no .clang-format file
" Note: BreakBeforeBraces: Attach doesn't attach enum braces
" Note: IndentGotoLabels: true doesn't indent properly within switch
let g:clang_format#style_options = {
    \ "AccessModifierOffset": -2,
    \ "AlignAfterOpenBracket": "Align",
    \ "AlignConsecutiveAssignments": "false",
    \ "AlignConsecutiveBitFields": "true",
    \ "AlignConsecutiveDeclarations": "false",
    \ "AlignConsecutiveMacros": "true",
    \ "AlignEscapedNewlines": "Left",
    \ "AlignOperands": "Align",
    \ "AlignTrailingComments": "true",
    \ "AllowAllArgumentsOnNextLine": "true",
    \ "AllowAllConstructorInitializersOnNextLine": "false",
    \ "AllowAllParametersOfDeclarationOnNextLine": "true",
    \ "AllowShortBlocksOnASingleLine": "Never",
    \ "AllowShortCaseLabelsOnASingleLine": "false",
    \ "AllowShortEnumsOnASingleLine": "false",
    \ "AllowShortFunctionsOnASingleLine": "None",
    \ "AllowShortIfStatementsOnASingleLine": "Never",
    \ "AllowShortLambdasOnASingleLine": "None",
    \ "AllowShortLoopsOnASingleLine": "false",
    \ "AlwaysBreakAfterReturnType": "None",
    \ "AlwaysBreakBeforeMultilineStrings": "true",
    \ "AlwaysBreakTemplateDeclarations": "No",
    \ "BinPackArguments": "false",
    \ "BinPackParameters": "false",
    \ "BreakBeforeBinaryOperators": "None",
    \ "BreakBeforeBraces": "Attach",
    \ "BreakBeforeTernaryOperators": "false",
    \ "BreakConstructorInitializers": "BeforeColon",
    \ "BreakInheritanceList": "BeforeColon",
    \ "BreakStringLiterals": "true",
    \ "ColumnLimit": 80,
    \ "CompactNamespaces": "false",
    \ "ConstructorInitializerAllOnOneLineOrOnePerLine": "true",
    \ "ConstructorInitializerIndentWidth": 4,
    \ "ContinuationIndentWidth": 8,
    \ "Cpp11BracedListStyle": "true",
    \ "DeriveLineEnding": "true",
    \ "DerivePointerAlignment": "false",
    \ "DisableFormat": "false",
    \ "FixNamespaceComments": "true",
    \ "IncludeBlocks": "Merge",
    \ "IndentCaseBlocks": "true",
    \ "IndentCaseLabels": "true",
    \ "IndentExternBlock": "Indent",
    \ "IndentGotoLabels": "true",
    \ "IndentPPDirectives": "AfterHash",
    \ "IndentWidth": 4,
    \ "IndentWrappedFunctionNames": "false",
    \ "KeepEmptyLinesAtTheStartOfBlocks": "false",
    \ "Language": "Cpp",
    \ "MaxEmptyLinesToKeep": 1,
    \ "NamespaceIndentation": "All",
    \ "PenaltyReturnTypeOnItsOwnLine": 999,
    \ "PointerAlignment": "Left",
    \ "ReflowComments": "true",
    \ "SortIncludes": "true",
    \ "SortUsingDeclarations": "true",
    \ "SpaceAfterCStyleCast": "false",
    \ "SpaceAfterLogicalNot": "false",
    \ "SpaceAfterTemplateKeyword": "false",
    \ "SpaceBeforeAssignmentOperators": "true",
    \ "SpaceBeforeCpp11BracedList": "true",
    \ "SpaceBeforeCtorInitializerColon": "true",
    \ "SpaceBeforeInheritanceColon": "true",
    \ "SpaceBeforeParens": "ControlStatements",
    \ "SpaceBeforeRangeBasedForLoopColon": "false",
    \ "SpaceBeforeSquareBrackets": "false",
    \ "SpaceInEmptyBlock": "false",
    \ "SpaceInEmptyParentheses": "false",
    \ "SpacesBeforeTrailingComments": 1,
    \ "SpacesInAngles": "false",
    \ "SpacesInCStyleCastParentheses": "false",
    \ "SpacesInConditionalStatement": "false",
    \ "SpacesInContainerLiterals": "false",
    \ "SpacesInParentheses": "false",
    \ "SpacesInSquareBrackets": "false",
    \ "Standard": "Cpp11",
    \ "TabWidth": 4,
    \ "UseCRLF": "false",
    \ "UseTab": "Never",
\}
" Autoformat C and C++ files on save
autocmd FileType c,cpp ClangFormatAutoEnable
autocmd FileType javascript,typescript,javascriptreact,typescriptreact ClangFormatAutoDisable

" ==============
" Autoformatting
" ==============
" Set the auto-formatter for java
"   NOTE: See http://astyle.sourceforge.net/astyle.html for details
autocmd BufNewFile,BufRead *.java set formatprg=astyle\ -A1s4SM80m0pHyj
" Use ggg to auto-format the whole file
nnoremap ggg gggqG<C-o><C-o>
" Use fff to auto-format a single function
nnoremap fff {gq}{=}
" Autoformat javascript files after they are saved
"   NOTE: Now handled by CoC instead. See CocConfig
"autocmd BufWritePost *.js,*.jsx,*.ts,*.tsx !prettier <afile> --write
" Make it so that markdown files are formatted properly with gq and also while
" typing in the file (automatically). See :h fo-table for details.
autocmd BufNewFile,BufRead *.md set formatoptions=tcqln
" Make it so that comments and code are formatted properly with gq in C files
autocmd BufNewFile,BufRead *.c,*.cpp,*.h,*.hpp,*.js,*.ts,*.jsx,*.tsx set formatoptions=croqlj
" Add '/**' to the list of allowable comment block starters. The default
" setting for this is 'sO:*\ -,mO:*\ ,exO:*/,s1:/*,mb:*,ex:*/,://', so this
" setting adds the 's1:/**' option to the list to support Doxygen-style
" comments. See :h comments for details.
autocmd BufNewFile,BufRead *.c,*.cpp,*.h,*.hpp,*.js,*.ts,*.jsx,*.tsx set comments=sO:*\ -,mO:*\ ,exO:*/,s1:/**,mb:*,ex:*/,s1:/*,mb:*,ex:*/,://

" ==========
" Statusline
" ==========
" Custom statusline generation function
function! MakeStatusLine() abort
    " True if the window is selected
    let focused = g:statusline_winid == win_getid(winnr())

    " Reset the statusline
    let statusline = ''

    " Color helper strings
    let colorNC = (focused ? '' : 'NC')
    let fileNameColor = '%#StatusLineFileName' . colorNC . '#'
    let metaColor = '%#StatusLineMeta' . colorNC . '#'
    let numberColor = '%#StatusLineNumber' . colorNC . '#'
    let percentColor = '%#StatusLinePercent' . colorNC . '#'
    let branchNameColor = '%#StatusLineGitBranchName' . colorNC . '#'

    " Add the buffer number
    let statusline .= metaColor . '%n%*'
    " Add the current git branch name
    "   NOTE: there is an issue here. The statusline is updated both when entering and exiting a buffer. This means that the
    "   call to fugitive#head() will set both the switched-from and switched-to buffer's status lines to have the branch of
    "   the switched-to buffer.
    let notInGit = len(fugitive#head()) == 0
    let statusline .= ' ' . (notInGit ? '' : (branchNameColor . '%{fugitive#head()}%* '))
    " Add the folder path
    let statusline .= "%{expand('%:~:h')}/"
    " Add file name
    let statusline .= fileNameColor . '%t%*'
    " Add modified flag
    let statusline .= ' %m'
    " Add spacer
    let statusline .= '%='
    " Add location within file
    let statusline .= '%(line ' . numberColor . '%l%* of ' . numberColor . '%L%*'
    let statusline .= ' [' . percentColor . '%p%%%*]'
    let statusline .= ' col ' . numberColor . '%c%*%)'
    " Add vim file type
    let statusline .= ' ' . metaColor . '%y'

    return statusline
endfunction
" Set the statusline to the output of the custom function
set statusline=%!MakeStatusLine()
" Make sure there is always a statusline at the very bottom window
set laststatus=2

" ======
" Colors
" ======
" Enable syntax coloring
syntax on
" Set the color scheme
colorscheme kyle
" Highlights matching parentheses, brackets, etc. on hover
set showmatch
" Highlight the current line in insert mode
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul
autocmd BufRead * set nocul
" Turn spell-checking on when editing a .notes file
autocmd BufRead,BufNewFile * set nospell
autocmd BufRead,BufNewFile *.notes set spell
" Always show all characters in markdown files
autocmd BufEnter,BufRead,BufNewFile *.md set conceallevel=0

" ======
" Typing
" ======
" Enable line numbering
set nu
" Set length of a tab
set tabstop=4
" Enable auto indent after return
set autoindent
" Enable smarter auto indenting
set smartindent
" Use spaces instead of tabs
set expandtab
" When using >> to indent, use indent size 4
set shiftwidth=4
" Allow backspacing over everything in insert mode
set backspace=2
" Keep 4 lines above/below cursor
set scrolloff=4
" Make the backspace key work
set backspace=indent,eol,start
" Auto-insert } when typing {<CR> in insert mode
inoremap {<CR> {<CR><CR>}<ESC>kcc

" =====
" Mouse
" =====
" Enable mouse in all modes
set mouse=a
" Hide mouse when typing
set mousehide
" Not sure this matters, but it should make the mouse work, I think
set ttymouse=xterm2

" =========
" Searching
" =========
" Ignore case in searches
set ignorecase
" Highlight searches
set hlsearch
" Show search matches as the search is being typed
set incsearch
" Use clc in command mode to clear the search
cnoremap clc<CR> let @/ = ""<CR>
" Use // in visual mode to search for what is highlighted
vnoremap // y/<C-R>"<CR>
" Make commands apply to all lines (global) by default
set gdefault
" Show filepath completion in status line
set wildmenu

" ============
" GUI Elements
" ============
" Show mode in bottom-left corner
set showmode
" Show partial command in bottom right corner
set showcmd
" Toggle the ruler on or off
:command! Ruler set colorcolumn=81
:command! Noruler set colorcolumn=
" Resize the window (when not maximized)
nnoremap <S-Left> :set columns-=10<CR>
nnoremap <S-Right> :set columns+=10<CR>
nnoremap <S-Up> :set lines-=5<CR>
nnoremap <S-Down> :set lines+=5<CR>
" Show search messages ([X/Y] in bottom right for match X of Y)
set shortmess-=s
set shortmess-=S

" =====
" NETRW
" =====
" Use tree layout by default
let g:netrw_liststyle = 3
" Hide the banner
let g:netrw_banner = 0
" Use default width of 40 columns
let g:netrw_winsize = 20
" Open files in the netrw window
let g:netrw_browse_split = 0
" Use the :Tree command to open netrw in Vim's working directory
command! -nargs=0 Tree :execute 'Vexplore' getcwd()

" ===========
" Performance
" ===========
" Helps the screen redraw
set ttyfast

" ============
" Key Mappings
" ============
" Use jk to exit insert mode
inoremap jk <ESC>
" Move between windows faster
"   NOTE: moving left from insert mode doesn't work because of a bug
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
"inoremap <C-k> <ESC><C-w>k
"inoremap <C-j> <ESC><C-w>j
"inoremap <C-h> <ESC><C-w>h
"inoremap <C-l> <ESC><C-w>l
" Use ; for command mode
nnoremap ; :
" Move along rows instead of lines (for lines that wrap around)
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap ^ g^
nnoremap $ g$
" Use space to center the screen
nnoremap <space> zz
" Center the screen after searching
nnoremap n nzzlN
nnoremap N NzzlN
nnoremap * *zzlN
nnoremap # #zzlN
" Use , + direction to resize windows
nnoremap <Leader>h :vertical resize +3<CR>
nnoremap <Leader>j :resize +3<CR>
nnoremap <Leader>k :resize -3<CR>
nnoremap <Leader>l :vertical resize -3<CR>
" Normally <C-w>| and <C-w>_ maximize windows. Use <C-w>- and <C-w>\ to minimize
nnoremap <C-w>- :resize 0<CR>
nnoremap <C-w>\ :vertical resize 0<CR>
" Select current block from visual mode
vnoremap i} <ESC>{jV}k
vnoremap i{ <ESC>{jV}k
" Add an alias for the scriptnames command
cnoremap scripts<CR> scriptnames<CR>
" Allow for accidental capital letters when saving or quitting
cnoremap W<CR> w<CR>
cnoremap X<CR> x<CR>
cnoremap Q<CR> q<CR>
cnoremap W<CR> w<CR>
" Custom function for scrolling 1/4 of the screen
function! ScrollQuarter(move)
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
nnoremap <C-U> :call ScrollQuarter('up')<CR>
nnoremap <C-D> :call ScrollQuarter('down')<CR>
" Printline shortcuts
autocmd FileType java inoremap <buffer> sout<TAB> System.out.println("");<ESC>hhi
autocmd FileType c    inoremap <buffer> sout<TAB> fprintf(stderr, "\n");<ESC>hhhhi
autocmd FileType cpp  inoremap <buffer> sout<TAB> fprintf(stderr, "\n");<ESC>hhhhi
autocmd FileType javascript,typescript,javascriptreact,typescriptreact inoremap <buffer> clog<TAB> console.log();<ESC>hi
" use qw for autocomplete
inoremap qw <C-N>

" =====
" Files
" =====
" Do not create swap files
set noswapfile
" Do not create backup files
set nobackup
" Set encoding type
set encoding=utf-8
" Highlight Jenkinsfile as a Groovy script
autocmd BufNewFile,BufRead Jenkinsfile set filetype=groovy

" =====================
" General Configuration
" =====================
" Make bash aliases work with external commands
let $BASH_ENV = "~/.bash_aliases"
" Check for external file updates on buffer enter or idle cursor
autocmd BufEnter * :checktime
autocmd CursorHold,CursorHoldI * checktime

" ========
" Commands
" ========
" Show what kind of syntactic object the cursor is over
:command! WhatIsThis :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
" Open a new split showing all existing color definitions
:command! ColorMap :so $VIMRUNTIME/syntax/hitest.vim
" Save and compile java files
command! JavaCompile w | !clear && javac -g %
" Run current java file
command! Java !clear && java -ea %:r

