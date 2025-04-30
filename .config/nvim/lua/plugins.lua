return function()
    -- Lazy.nvim
    -- NOTE: lazy installs files at ~/.local/share/nvim/lazy
    local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            'git',
            'clone',
            '--filter=blob:none',
            'https://github.com/folke/lazy.nvim.git',
            '--branch=stable',
            lazypath,
        })
    end
    vim.opt.rtp:prepend(lazypath)
    local plugins = {
        -- visual mode comment/uncomment
        require('plugins.nerdcommenter')(),
        -- file explorer
        require('plugins.nerdtree')(),
        -- display git branch on statusline
        require('plugins.vim-fugitive')(),
        -- show vertical lines for indented blocks
        --require('plugins.indentline')(),
        -- highlight trailing whitespace
        require('plugins.vim-better-whitespace')(),
        -- allows swapping windows with <leader>w
        require('plugins.vim-windowswap')(),
        -- better syntax highlighting for python
        require('plugins.python-syntax')(),
        -- makes the tabline pretty
        require('plugins.taboo')(),
        -- improve syntax coloring for jsx
        require('plugins.vim-jsx-pretty')(),
        require('plugins.typescript-vim')(),
        require('plugins.vim-jsx-typescript')(),
        -- syntax highlighting for yang files
        require('plugins.yang')(),
        -- syntax highlighting for .jsonc files
        require('plugins.vim-jsonc')(),
        -- autocomplete and syntax checking
        require('plugins.coc')(),
        -- autoformatting for python
        require('plugins.black')(),
        -- syntax highlighting for toml
        require('plugins.vim-toml')(),
        -- folding in markdown
        --require('plugins.vim-markdown-folding')(),
        -- utility for editing surrounding symbols like quotes and xml tags
        require('plugins.vim-surround')(),
        -- allow f, t, F, and T to wrap across lines
        require('plugins.vim-fanfingtastic')(),
        -- show context of current function
        require('plugins.context')(),
        -- syntax highlighting for mdx files
        require('plugins.vim-mdx-js')(),
        -- welcome screen/screensaver
        require('plugins.drop')(),
        -- tool for moving around the screen more easily
        require('plugins.flash')(),
        -- core utility for language server functionality
        require('plugins.nvim-treesitter')(),
        -- status updater for lsp
        require('plugins.fidget')(),
        -- searcher
        require('plugins.telescope')(),
        -- colorscheme
        require('plugins.kanagawa')(),
        -- search highlighting tool
        require('plugins.cash')(),
        -- maintain window sizes when resizing vim
        require('plugins.bufresize')(),
        -- file browser for editing file names/permissions
        require('plugins.oil')(),
        -- make w, e, and b behave better
        require('plugins.spider')(),
        -- nvim auto formatter
        require('plugins.conform')(),
        -- utility for editing surrounding symbols like quotes and xml tags
        require('plugins.mini-surround')(),
        -- mark jumping plugin
        require('plugins.mark-radar')(),
        -- buffer jumping plugin
        require('plugins.bufjump')(),
        -- notification UI element
        require('plugins.notify')(),
        -- extends <C-a> and <C-x> to toggle booleans
        require('plugins.boole')(),
        -- get github/gitlab links from code using <Leader>gb
        require('plugins.gitlinker')(),
        -- SQL plugin
        require('plugins.dadbod')(),
        -- splash screen
        require('plugins.minintro')(),
        -- fancier search UI
        require('plugins.hlslens')(),
        -- diff viewer
        require('plugins.diffview')(),
        -- find-and-replacer
        require('plugins.spectre')(),
        -- auto-close unused buffers
        require('plugins.hbac')(),
        -- multi-cursor plugin
        require('plugins.vim-visual-multi')(),
        -- quickfix improvement plugin
        require('plugins.quicker')(),
        -- indentation movement mappings
        require('plugins.indentwise')(),
        -- re-open closed windows
        require('plugins.undoquit')(),
        -- allow scrolling past the top of a file
        require('plugins.go-up')(),
        -- automatically insert matching parentheses and quotes
        require('plugins.nvim-autopairs')(),
        -- spell checker
        --require('plugins.typos-lsp')(),
        -- replacement for indentline
        require('plugins.indent-blankline')(),
        -- easy way to edit registers
        require('plugins.registereditor')(),
    }

    -- load fewer plugins when using firenvim
    if vim.g.started_by_firenvim == true then
        plugins = {
            require('plugins.nerdcommenter')(),
            require('plugins.vim-fugitive')(),
            require('plugins.indentline')(),
            require('plugins.vim-windowswap')(),
            require('plugins.taboo')(),
            require('plugins.vim-surround')(),
            require('plugins.vim-fanfingtastic')(),
            require('plugins.drop')(),
            require('plugins.flash')(),
            require('plugins.telescope')(),
            require('plugins.kanagawa')(),
            require('plugins.cash')(),
            require('plugins.spider')(),
            require('plugins.mini-surround')(),
            require('plugins.mark-radar')(),
            require('plugins.boole')(),
            require('plugins.hlslens')(),
            require('plugins.vim-visual-multi')(),
            require('plugins.indentwise')(),
            require('plugins.go-up')(),
            require('plugins.nvim-autopairs')(),
            -- use vim in the browser
            require('plugins.firenvim')(),
        }
    end

    -- set up plugins
    require('lazy').setup(plugins, {})

    -- Add package to jump between html tags
    vim.cmd('packadd! matchit')
end
