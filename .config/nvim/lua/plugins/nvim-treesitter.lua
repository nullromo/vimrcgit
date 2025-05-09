-- core utility for language server functionality

return function()
    return {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup({
                -- language parsers to install
                ensure_installed = {
                    -- required defaults
                    'c',
                    'lua',
                    'vim',
                    'vimdoc',
                    'query',
                    -- additional languages
                    'bash',
                    'cmake',
                    'cpp',
                    'css',
                    'csv',
                    'diff',
                    'dockerfile',
                    'doxygen',
                    'git_config',
                    'git_rebase',
                    'gitcommit',
                    'gitignore',
                    'html',
                    'http',
                    'javascript',
                    'jsdoc',
                    'json',
                    'jsonc',
                    'luadoc',
                    'make',
                    'markdown',
                    'markdown_inline',
                    'python',
                    'regex',
                    'sql',
                    'ssh_config',
                    'toml',
                    'tsx',
                    'typescript',
                    'xml',
                    'yaml',
                    'yang',
                },
                -- install parsers synchronously
                sync_install = false,
                -- install parsers when opening buffers
                auto_install = false,
                -- language parsers NOT to install
                ignore_install = {},
                -- enable treesitter-based syntax highlighting
                highlight = { enable = true },
                -- enable treesitter-based indentation
                indent = { enable = true },
                -- extra modules for treesitter
                modules = {},
            })

            -- for some reason, treesitter seems to be hiding some text in help
            -- files. The conceallevel is set to 2 from vim itself, but for
            -- some reason the text is the same color as the background. One
            -- way around this is to just set conceallevel to 0
            vim.api.nvim_create_autocmd({ 'FileType' }, {
                pattern = 'help',
                command = 'set conceallevel=0',
                desc = 'Do not conceal help',
            })
        end,
    }
end
