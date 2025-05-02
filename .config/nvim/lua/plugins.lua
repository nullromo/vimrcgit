return function()
    -- set up Lazy.nvim
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

    -- specify plugins to load
    local pluginNames = {
        'nerdcommenter',
        'nerdtree',
        'vim-fugitive',
        -- show vertical lines for indented blocks
        --require('plugins.indentline')(),
        'vim-better-whitespace',
        'vim-windowswap',
        'python-syntax',
        'taboo',
        'vim-jsx-pretty',
        'typescript-vim',
        'vim-jsx-typescript',
        'yang',
        'vim-jsonc',
        'coc',
        'black',
        'vim-toml',
        -- folding in markdown
        --require('plugins.vim-markdown-folding')(),
        'vim-surround',
        'vim-fanfingtastic',
        'context',
        'vim-mdx-js',
        'drop',
        'flash',
        'nvim-treesitter',
        'fidget',
        'telescope',
        'kanagawa',
        'cash',
        'bufresize',
        'oil',
        'spider',
        'conform',
        'mini-surround',
        'mark-radar',
        'bufjump',
        'notify',
        'boole',
        'gitlinker',
        'dadbod',
        'minintro',
        'hlslens',
        'diffview',
        'spectre',
        'hbac',
        'vim-visual-multi',
        'quicker',
        'indentwise',
        'undoquit',
        'go-up',
        'nvim-autopairs',
        -- spell checker
        --require('plugins.typos-lsp')(),
        'indent-blankline',
        'registereditor',
    }

    -- load fewer plugins when using firenvim
    if vim.g.started_by_firenvim == true then
        pluginNames = {
            'nerdcommenter',
            'vim-fugitive',
            'indentline',
            'vim-windowswap',
            'taboo',
            'vim-surround',
            'vim-fanfingtastic',
            'drop',
            'flash',
            'telescope',
            'kanagawa',
            'cash',
            'spider',
            'mini-surround',
            'mark-radar',
            'boole',
            'hlslens',
            'vim-visual-multi',
            'indentwise',
            'go-up',
            'nvim-autopairs',
            -- use vim in the browser
            'firenvim',
        }
    end

    -- build plugins table
    local plugins = {}
    for _, pluginName in ipairs(pluginNames) do
        table.insert(plugins, require('plugins.' .. pluginName)())
    end

    -- set up plugins
    require('lazy').setup(plugins, {})

    -- Add package to jump between html tags
    vim.cmd('packadd! matchit')
end
