return function()
    return {
        'masukomi/vim-markdown-folding',
        init = function ()
            -- Keep content on fold header
            vim.g.markdown_fold_override_foldtext = 0
        end,
        config = function ()
            -- Expand all folds by default
            vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' },
                {
                    pattern = '*.md,*.mdx',
                    command = 'normal zR',
                    desc = 'expand all folds by default',
                }
            )

            -- Use nested folding for different header levels
            vim.api.nvim_create_autocmd({ 'FileType'} ,
                {
                    pattern = 'markdown',
                    command = 'set foldexpr=NestedMarkdownFolds()',
                    desc = 'use nested folding',
                }
            )
        end,
        ft = {
            'markdown',
        },
    }
end
