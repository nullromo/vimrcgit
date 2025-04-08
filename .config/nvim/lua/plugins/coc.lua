return function()
    return {
        'neoclide/coc.nvim',
        branch = 'release',
        config = function()
            -- install CoC extensions when the service starts
            vim.g.coc_global_extensions = {
                'coc-tsserver',
                'coc-json',
                'coc-html',
                'coc-css',
                'coc-pyright',
                'coc-git',
                'coc-prettier',
                'coc-eslint',
                'coc-clangd',
                'coc-webview',
                'coc-markdown-preview-enhanced',
                'coc-lua',
                'coc-db',
                '@yaegassy/coc-marksman',
                'coc-typos',
            }

            -- navigate the completion list with control + j/k in addition to
            -- control + n/p
            vim.keymap.set('i', '<C-n>', function()
                if vim.fn['coc#pum#visible']() then
                    return vim.fn['coc#pum#next'](1)
                end
                return '<C-n>'
            end, { expr = true, desc = 'CoC autocomplete next' })
            vim.keymap.set('i', '<C-p>', function()
                if vim.fn['coc#pum#visible']() then
                    return vim.fn['coc#pum#prev'](1)
                end
                return '<C-p>'
            end, { expr = true, desc = 'CoC autocomplete previous' })

            -- move between errors
            vim.keymap.set(
                'n',
                '[[',
                '<Plug>(coc-diagnostic-prev)',
                { remap = true, silent = true, desc = 'CoC next diagnostic' }
            )
            vim.keymap.set('n', ']]', '<Plug>(coc-diagnostic-next)', {
                remap = true,
                silent = true,
                desc = 'CoC previous diagnostic',
            })

            -- Vim's default motions to jump between typos OR "strange words"
            -- are [s and ]s. Vim's default motions to jump between typos are
            -- [S and ]S. Since I don't care about "strange words," I want to
            -- map the default [S and ]S to [s and]s. I also want to map
            -- coc-typos to [S and ]S.
            vim.keymap.set('n', ']s', ']S', {
                silent = true,
                desc = 'Use lowercase s for typo backward jump',
            })
            vim.keymap.set('n', '[s', '[S', {
                silent = true,
                desc = 'Use lowercase s for typo forward jump',
            })
            vim.keymap.set(
                'n',
                ']S',
                '<Plug>(coc-typos-next)',
                { silent = true, desc = 'CoC next typo' }
            )
            vim.keymap.set(
                'n',
                '[S',
                '<Plug>(coc-typos-prev)',
                { silent = true, desc = 'CoC previous typo' }
            )

            -- fix typos
            vim.keymap.set(
                'n',
                'Z=',
                '<Plug>(coc-typos-fix)',
                { silent = true, desc = 'CoC fix typo' }
            )

            -- allow the [[ and ]] to work in python
            vim.g.no_python_maps = 1

            -- use :Check to get errors current buffer in location list
            vim.api.nvim_create_user_command(
                'Check',
                ':CocDiagnostics()<CR>',
                { bang = true, desc = 'open CoC diagnostics' }
            )

            -- GoTo code navigation.
            vim.keymap.set(
                'n',
                'gd',
                '<Plug>(coc-definition)',
                { remap = true, silent = true, desc = 'CoC jump to definition' }
            )
            vim.keymap.set('n', 'gy', '<Plug>(coc-type-definition)', {
                remap = true,
                silent = true,
                desc = 'CoC jump to type definition',
            })
            vim.keymap.set('n', 'gi', '<Plug>(coc-implementation)', {
                remap = true,
                silent = true,
                desc = 'CoC jump to implementation',
            })
            vim.keymap.set(
                'n',
                'gr',
                '<Plug>(coc-references)',
                { remap = true, silent = true, desc = 'CoC find references' }
            )

            -- jump between git changes (chunks)
            vim.keymap.set('n', '[g', '<Plug>(coc-git-prevchunk)', {
                remap = true,
                silent = true,
                desc = 'CoC previous git change',
            })
            vim.keymap.set(
                'n',
                ']g',
                '<Plug>(coc-git-nextchunk)',
                { remap = true, silent = true, desc = 'CoC next git change' }
            )

            -- jump between git conflicts
            vim.keymap.set('n', '[c', '<Plug>(coc-git-prevconflict)', {
                remap = true,
                silent = true,
                desc = 'CoC previous git conflict',
            })
            vim.keymap.set(
                'n',
                ']c',
                '<Plug>(coc-git-nextconflict)',
                { remap = true, silent = true, desc = 'CoC next git conflict' }
            )

            -- show git chunk diff
            vim.keymap.set(
                'n',
                'gs',
                '<Plug>(coc-git-chunkinfo)',
                { remap = true, silent = true, desc = 'CoC git diff' }
            )

            -- shortcut for CocAction
            vim.api.nvim_create_user_command(
                'CocAction',
                'normal <Plug>(coc-codeaction)',
                { bang = true, desc = 'CoC action' }
            )

            -- use K for hover-style documentation/help
            function _G.show_docs()
                local cw = vim.fn.expand('<cword>')
                if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
                    vim.api.nvim_command('h ' .. cw)
                elseif vim.api.nvim_eval('coc#rpc#ready()') then
                    vim.fn.CocActionAsync('doHover')
                else
                    vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
                end
            end
            vim.keymap.set(
                'n',
                'K',
                '<CMD>lua _G.show_docs()<CR>',
                { silent = true, desc = 'CoC show hover' }
            )

            -- highlight all references to the symbol where the cursor is
            vim.api.nvim_create_autocmd('CursorHold', {
                pattern = '*',
                command = "silent call CocActionAsync('highlight')",
                desc = 'CoC hover highlight',
            })
            vim.opt.updatetime = 100

            -- add command for renaming variables
            vim.api.nvim_create_user_command(
                'Rename',
                'normal <Plug>(coc-rename)',
                { bang = true, desc = 'CoC rename' }
            )

            -- add command for renaming files
            vim.api.nvim_create_user_command(
                'RenameFile',
                ':CocCommand workspace.renameCurrentFile',
                { bang = true, desc = 'CoC rename file' }
            )

            -- add command for organizing imports
            vim.api.nvim_create_user_command('OrganizeImports', function()
                vim.cmd(
                    "call CocAction('runCommand', 'editor.action.organizeImport')"
                )
                -- In JS/TS files, the tsserver's organizeImport feature will
                -- disagree with eslint's import/order rule. To fix this, an
                -- eslint auto-fix needs to be run after the organizeImport is
                -- finished
                if
                    vim.bo.filetype == 'typescript'
                    or vim.bo.filetype == 'typescriptreact'
                then
                    -- Note, this will not work because CoC does not know about
                    -- the eslint action until a few hundred ms after the
                    -- organizeImport is finished. So it will hit this line, do
                    -- nothing, and then the eslint errors will pop up after
                    -- that. The "eslint.autoFixOnSave" option in CocConfig
                    -- will take care of autofixing, and there is also the
                    -- :AutoFixAll user command below to run the autofixer
                    -- manually. See
                    -- https://github.com/neoclide/coc.nvim/issues/5136 for
                    -- more info
                    vim.cmd(
                        "call CocAction('runCommand', 'eslint.executeAutofix')"
                    )
                end
            end, {
                bang = true,
                nargs = 0,
                desc = 'CoC organize imports',
            })

            -- shortcut for auto-fixing eslint errors
            vim.api.nvim_create_user_command(
                'AutoFixAll',
                "call CocAction('runCommand', 'eslint.executeAutofix')",
                { bang = true, desc = 'Auto-fix all eslint errors' }
            )

            -- shortcut for prettier to format javascript/css
            vim.api.nvim_create_user_command(
                'Prettier',
                ':CocCommand prettier.formatFile',
                { bang = true, nargs = 0, desc = 'Prettier format file' }
            )

            -- shortcut for switching to C header files
            vim.api.nvim_create_user_command(
                'GHeader',
                'CocCommand clangd.switchSourceHeader',
                { bang = true, desc = 'CoC jump to header file' }
            )
            vim.api.nvim_create_user_command(
                'Header',
                'rightbelow sp | CocCommand clangd.switchSourceHeader',
                { bang = true, desc = 'CoC open header file horizontally' }
            )
            vim.api.nvim_create_user_command(
                'VHeader',
                'rightbelow vsp | CocCommand clangd.switchSourceHeader',
                { bang = true, desc = 'CoC open header file vertically' }
            )

            -- scroll popups with <C-f> and <C-b>
            vim.keymap.set('n', '<C-f>', 'coc#float#scroll(1)', {
                silent = true,
                nowait = true,
                expr = true,
                desc = 'CoC scroll popup down',
            })
            vim.keymap.set('n', '<C-b>', 'coc#float#scroll(0)', {
                silent = true,
                nowait = true,
                expr = true,
                desc = 'CoC scroll popup up',
            })

            -- provide a user command for creating a table of contents in a markdown file
            vim.api.nvim_create_user_command(
                'TableOfContents',
                ":call CocActionAsync('codeAction', '', ['source'], v:true)",
                { desc = 'coc-marksman create table of contents' }
            )
        end,
        lazy = false,
    }
end
