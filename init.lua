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
    {
        'preservim/nerdcommenter',
        config = function ()
            -- Use c/u to comment/uncomment the selection in visual mode
            vim.keymap.set('v', 'c', ":call nerdcommenter#Comment('n', 'Comment')<CR>")
            vim.keymap.set('v', 'u', ":call nerdcommenter#Comment('n', 'Uncomment')<CR>")
        end,
    },
    -- File explorer
    {
        'preservim/nerdtree',
        init = function ()
            -- Close NERDTree when a file is opened
            vim.g.NERDTreeQuitOnOpen = 1
            -- Do not show bookmarks
            vim.g.NERDTreeShowBookmarks = 0
            -- Show files and hidden files in NREDTree
            vim.g.NERDTreeShowFiles = 1
            vim.g.NERDTreeShowHidden = 1
            -- Show line numbers in NERDTree
            vim.g.NERDTreeShowLineNumbers = 1
        end,
    },
    -- Display git branch on statusline
    'tpope/vim-fugitive',
    -- Show vertical lines for indented blocks
    {
        'yggdroot/indentline',
        init = function ()
            -- Set the color
            vim.g.indentLine_color_term = 'brown'
            -- Set the character
            vim.g.indentLine_char = '|'
            -- Do not use in json or help files
            --   NOTE: since this plugin uses vim's conceal feature, and that messes up
            --   JSON quotes, it doens't really work in json files or markdown
            vim.g.indentLine_fileTypeExclude = {'json', 'jsonc', 'help', 'markdown', 'markdown.mdx'}
        end,
    },
    -- Highlight trailing whitespace
    'ntpeters/vim-better-whitespace',
    -- Allows swapping windows with <Leader>w
    {
        'wesQ3/vim-windowswap',
        init = function ()
            -- Prevent default bindings
            vim.g.windowswap_map_keys = 0
        end,
        config = function ()
            -- Use ,w to 'yank' and 'paste' windows
            vim.keymap.set('n', '<Leader>w', ':call WindowSwap#EasyWindowSwap()<CR>', {silent = true})
        end,
    },
    -- Better syntax highlighting for python
    {
        'vim-python/python-syntax',
        init = function ()
            -- Turn on all highlighting
            vim.g.python_highlight_all = 1
        end,
    },
    {
        -- Makes the tabline pretty
        'gcmt/taboo.vim',
        init = function ()
            -- Allows tab names to be saved in the session file
            vim.opt.sessionoptions = {'blank', 'buffers', 'curdir', 'folds', 'globals', 'help', 'localoptions', 'options', 'resize', 'tabpages', 'terminal', 'winpos', 'winsize'}
            -- Set the tab format for default tabs
            vim.g.taboo_tab_format = '├%N%U╯%f %m'
            -- Set the tab format for renamed tabs
            vim.g.taboo_renamed_tab_format = '├%N%U╯%l %m'
            -- Put a clock in the top-right corner of the tabline
            vim.g.taboo_close_tabs_label = "%{substitute(strftime('%a %e %b %l:%M:%S %p'), '  ', ' ', 'g')}"
            -- Update the clock whenever possible (when the cursor moves)
            vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {pattern = '*', command = 'silent redrawtabline'})
            -- Always show the tabline
            vim.opt.showtabline = 2
        end,
        config = function ()
            -- Redraw the tabline every minute to update the clock
            vim.cmd([[
                function RedrawTabline(timerID) abort
                    silent redrawtabline
                endfunction
                call timer_start(60000, 'RedrawTabline', {'repeat': -1})
            ]])
        end,
    },
    -- Improve syntax coloring for JSX
    'MaxMEllon/vim-jsx-pretty',
    'leafgarland/typescript-vim',
    'peitalin/vim-jsx-typescript',
    -- Syntax highlighting for YANG files
    'nathanalderson/yang.vim',
    -- Syntax highlighting for .jsonc files
    'kevinoid/vim-jsonc',
    {
        -- Autocomplete and syntax checking
        'neoclide/coc.nvim',
        branch = 'release',
        config = function ()
            -- ===
            -- COC
            -- ===
            -- Install CoC extensions when the service starts
            vim.g.coc_global_extensions = {'coc-tsserver', 'coc-json', 'coc-html', 'coc-css', 'coc-pyright', 'coc-git', 'coc-prettier', 'coc-eslint', 'coc-clangd', 'coc-webview', 'coc-markdown-preview-enhanced', 'coc-sumneko-lua'}
            -- Navigate the completion list with control + j/k in addition to control + n/p
            vim.keymap.set('i', '<C-n>',
                function()
                    if vim.fn['coc#pum#visible']() then
                        return vim.fn['coc#pum#next'](1)
                    end
                    return '<C-n>'
                end,
                {expr = true}
            )
            vim.keymap.set('i', '<C-p>',
                function()
                    if vim.fn['coc#pum#visible']() then
                        return vim.fn['coc#pum#prev'](1)
                    end
                    return '<C-p>'
                end,
                {expr = true}
            )
            -- Move between errors
            vim.keymap.set('n', '[[', '<Plug>(coc-diagnostic-prev)', {remap = true, silent = true})
            vim.keymap.set('n', ']]', '<Plug>(coc-diagnostic-next)', {remap = true, silent = true})
            -- " Allow the [[ and ]] to work in python
            vim.g.no_python_maps = 1
            -- Use :Check to get errors current buffer in location list
            vim.api.nvim_create_user_command('Check', ':CocDiagnostics()<CR>', {bang = true})
            -- GoTo code navigation.
            vim.keymap.set('n', 'gd', '<Plug>(coc-definition)', {remap = true, silent = true})
            vim.keymap.set('n', 'gy', '<Plug>(coc-type-definition)', {remap = true, silent = true})
            vim.keymap.set('n', 'gi', '<Plug>(coc-implementation)', {remap = true, silent = true})
            vim.keymap.set('n', 'gr', '<Plug>(coc-references)', {remap = true, silent = true})
            -- jump between git changes (chunks)
            vim.keymap.set('n', '[g', '<Plug>(coc-git-prevchunk)', {remap = true, silent = true})
            vim.keymap.set('n', ']g', '<Plug>(coc-git-nextchunk)', {remap = true, silent = true})
            -- jump between git conflicts
            vim.keymap.set('n', '[c', '<Plug>(coc-git-prevconflict)', {remap = true, silent = true})
            vim.keymap.set('n', ']c', '<Plug>(coc-git-nextconflict)', {remap = true, silent = true})
            -- show git chunk diff
            vim.keymap.set('n', 'gs', '<Plug>(coc-git-chunkinfo)', {remap = true, silent = true})
            -- Shortcut for CocAction
            vim.api.nvim_create_user_command('CocAction', 'normal <Plug>(coc-codeaction)', {bang = true})
            -- Use K for hover-style documentation/help
            function _G.show_docs()
                local cw = vim.fn.expand('<cword>')
                if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
                    vim.api.nvim_command('h ' .. cw)
                elseif vim.api.nvim_eval('coc#rpc#ready()') then
                    vim.fn.CocActionAsync('doHover')
                else
                    vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
                end
            end
            vim.keymap.set('n', 'K', '<CMD>lua _G.show_docs()<CR>', {silent = true})
            -- Highlight all references to the symbol where the cursor is
            vim.api.nvim_create_autocmd('CursorHold', {pattern = '*', command = "silent call CocActionAsync('highlight')"})
            vim.opt.updatetime = 100
            -- Add command for renaming variables
            vim.api.nvim_create_user_command('Rename', 'normal <Plug>(coc-rename)', {bang = true})
            -- Add command for renaming files
            vim.api.nvim_create_user_command('RenameFile', ':CocCommand workspace.renameCurrentFile', {bang = true})
            -- Add command for organizing imports
            vim.api.nvim_create_user_command('OrganizeImports', ":call CocAction('runCommand', 'editor.action.organizeImport')", {bang = true, nargs = 0})
            -- Shortcut for perttier to format javascript/css
            vim.api.nvim_create_user_command('Prettier', ':CocCommand prettier.formatFile', {bang = true, nargs = 0})
            -- Shortcut for switching to C header files
            vim.api.nvim_create_user_command('GHeader', 'CocCommand clangd.switchSourceHeader', {bang = true})
            vim.api.nvim_create_user_command('Header', 'rightbelow sp | CocCommand clangd.switchSourceHeader', {bang = true})
            vim.api.nvim_create_user_command('VHeader', 'rightbelow vsp | CocCommand clangd.switchSourceHeader', {bang = true})
            -- Scroll popups with <C-f> and <C-b>
            vim.keymap.set('n', '<C-f>', 'coc#float#scroll(1)', {silent = true, nowait = true, expr = true})
            vim.keymap.set('n', '<C-b>', 'coc#float#scroll(0)', {silent = true, nowait = true, expr = true})
        end,
    },
    {
        -- Autoformatting for python
        'psf/black',
        init = function ()
            vim.g.black_skip_magic_trailing_comma = 1
        end,
        config = function ()
            vim.api.nvim_create_autocmd({'BufWritePre'}, {pattern = '*.py', command = "execute ':Black'"})
        end,
    },
    -- Syntax highlighting for toml
    'cespare/vim-toml',
    {
        -- Autoformatting for C files
        'rhysd/vim-clang-format',
        init = function ()
            -- Set options for clang-format in case there is no .clang-format file
            -- Note: BreakBeforeBraces: Attach doesn't attach enum braces
            -- Note: IndentGotoLabels: true doesn't indent properly within switch
            vim.g['clang_format#style_options'] = {
                AccessModifierOffset = -2,
                AlignAfterOpenBracket = "Align",
                AlignConsecutiveAssignments = "false",
                AlignConsecutiveBitFields = "true",
                AlignConsecutiveDeclarations = "false",
                AlignConsecutiveMacros = "true",
                AlignEscapedNewlines = "Left",
                AlignOperands = "Align",
                AlignTrailingComments = "true",
                AllowAllArgumentsOnNextLine = "true",
                AllowAllConstructorInitializersOnNextLine = "false",
                AllowAllParametersOfDeclarationOnNextLine = "true",
                AllowShortBlocksOnASingleLine = "Never",
                AllowShortCaseLabelsOnASingleLine = "false",
                AllowShortEnumsOnASingleLine = "false",
                AllowShortFunctionsOnASingleLine = "None",
                AllowShortIfStatementsOnASingleLine = "Never",
                AllowShortLambdasOnASingleLine = "None",
                AllowShortLoopsOnASingleLine = "false",
                AlwaysBreakAfterReturnType = "None",
                AlwaysBreakBeforeMultilineStrings = "true",
                AlwaysBreakTemplateDeclarations = "No",
                BinPackArguments = "false",
                BinPackParameters = "false",
                BreakBeforeBinaryOperators = "None",
                BreakBeforeBraces = "Attach",
                BreakBeforeTernaryOperators = "false",
                BreakConstructorInitializers = "BeforeColon",
                BreakInheritanceList = "BeforeColon",
                BreakStringLiterals = "true",
                ColumnLimit = 80,
                CompactNamespaces = "false",
                ConstructorInitializerAllOnOneLineOrOnePerLine = "true",
                ConstructorInitializerIndentWidth = 4,
                ContinuationIndentWidth = 8,
                Cpp11BracedListStyle = "true",
                DeriveLineEnding = "true",
                DerivePointerAlignment = "false",
                DisableFormat = "false",
                FixNamespaceComments = "true",
                IncludeBlocks = "Merge",
                IndentCaseBlocks = "true",
                IndentCaseLabels = "true",
                IndentExternBlock = "Indent",
                IndentGotoLabels = "true",
                IndentPPDirectives = "AfterHash",
                IndentWidth = 4,
                IndentWrappedFunctionNames = "false",
                KeepEmptyLinesAtTheStartOfBlocks = "false",
                Language = "Cpp",
                MaxEmptyLinesToKeep = 1,
                NamespaceIndentation = "All",
                PenaltyReturnTypeOnItsOwnLine = 999,
                PointerAlignment = "Left",
                ReflowComments  = "true",
                SortIncludes = "true",
                SortUsingDeclarations = "true",
                SpaceAfterCStyleCast = "false",
                SpaceAfterLogicalNot = "false",
                SpaceAfterTemplateKeyword = "false",
                SpaceBeforeAssignmentOperators = "true",
                SpaceBeforeCpp11BracedList = "true",
                SpaceBeforeCtorInitializerColon = "true",
                SpaceBeforeInheritanceColon = "true",
                SpaceBeforeParens = "ControlStatements",
                SpaceBeforeRangeBasedForLoopColon = "false",
                SpaceBeforeSquareBrackets = "false",
                SpaceInEmptyBlock = "false",
                SpaceInEmptyParentheses = "false",
                SpacesBeforeTrailingComments = 1,
                SpacesInAngles = "false",
                SpacesInCStyleCastParentheses = "false",
                SpacesInConditionalStatement = "false",
                SpacesInContainerLiterals = "false",
                SpacesInParentheses = "false",
                SpacesInSquareBrackets = "false",
                Standard = "Cpp11",
                TabWidth = 4,
                UseCRLF = "false",
                UseTab = "Never"
            }
        end,
        config = function ()
            -- Autoformat C and C++ files on save
            vim.api.nvim_create_autocmd({'FileType'}, {pattern = 'c,cpp', command = 'ClangFormatAutoEnable'})
            vim.api.nvim_create_autocmd({'FileType'}, {pattern = 'javascript,typescript,javascriptreact,typescriptreact', command = 'ClangFormatAutoDisable'})
        end,
    },
    {
        -- Folding in markdown
        'masukomi/vim-markdown-folding',
        init = function ()
            -- Keep content on fold header
            vim.g.markdown_fold_override_foldtext = 0
        end,
        config = function ()
            -- Expand all folds by default
            vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {pattern = '*.md,*.mdx', command = 'normal zR'})
            -- Use nested folding for different header levels
            vim.api.nvim_create_autocmd({'FileType'}, {pattern = 'markdown', command = 'set foldexpr=NestedMarkdownFolds()'})
        end,
    },
    -- Utility for editing surrounding symbols like quotes and xml tags
    'tpope/vim-surround',
    -- Allow f, t, F, and T to wrap across lines
    'dahu/vim-fanfingtastic',
    {
        -- Show context of current function
        'wellle/context.vim',
        init = function ()
            -- Turn off by default
            vim.g.context_enabled = 0
            vim.g.context_highlight_tag = '<hide>'
        end,
        config = function ()
            -- Create a command to peek at the current context
            vim.api.nvim_create_user_command('Context', 'normal :ContextPeek<CR>', {bang = true})
        end,
    },
    -- Syntax highlighting for MDX files
    'jxnblk/vim-mdx-js',
    {
        -- Welcome screen/screensaver
        'folke/drop.nvim',
        config = function ()
            vim.api.nvim_create_autocmd({'VimEnter'}, {pattern = '*', callback =
                function()
                    require("drop").setup({
                        theme = {
                            symbols = {"*", "."},
                            colors = {"blue", "lightblue", "darkblue", "white", "lightgray"}
                        },
                        max = 170,
                        interval = 150,
                        screensaver = 1000 * 10 * 60,
                        filetypes = {},
                    })
                end
            })
        end,
    },
    {
        -- ???
        'folke/flash.nvim',
        event = 'VeryLazy',
        opts = {
            label = {
                -- only use lowercase letters for jump labels
                uppercase = false,
                -- use <CR> as the first label
                current = false,
                -- position the labels at the beginning of the search words
                after = false,
                before = true,
            },
            highlight = {
                backdrop = false,
            },
            modes = {
                search = {
                    enabled = false,
                },
                char = {
                    autohide = true,
                    search = {
                        wrap = true,
                    },
                    highlight = {
                        backdrop = false,
                        matches = false,
                        groups = {
                            label = "FlashMatch",
                        },
                    },
                },
            },
            remote_op = {
                motion = true,
            },
        },
        keys = {
            -- use C-f to activate flash during normal mode, operator pending mode, and visual mode
            { "<C-f>", mode = { "n", "o", "x" }, function() require("flash").jump() end, desc = "Flash" },
            --{ "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            -- use r to activate flash in operator pending mode
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            --{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        },
    },
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
