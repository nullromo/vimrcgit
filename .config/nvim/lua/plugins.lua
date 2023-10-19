return function()
    -- Lazy.nvim
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
        -- visual mode comment/uncomment
        require('plugins.nerdcommenter')(),
        -- file explorer
        require('plugins.nerdtree')(),
        -- display git branch on statusline
        require('plugins.vim-fugitive')(),
        -- show vertical lines for indented blocks
        require('plugins.indentline')(),
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
        -- autoformatting for c files
        require('plugins.vim-clang-format')(),
        -- folding in markdown
        require('plugins.vim-markdown-folding')(),
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
        -- installer for language servers
        require('plugins.mason')(),
        -- connector for language servers
        require('plugins.mason-lspconfig')(),
        -- lsp configuration
        require('plugins.nvim-lspconfig')(),
        -- status updater for lsp
        require('plugins.fidget')(),
        -- type hints and such for development of vim itself
        require('plugins.neodev')(),
    }
    require("lazy").setup(plugins, {})

    -- Add package to jump between html tags
    vim.cmd('packadd! matchit')
end