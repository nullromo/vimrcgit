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
            vim.api.nvim_create_user_command(
                'OrganizeImports',
                ":call CocAction('runCommand', 'editor.action.organizeImport')",
                { bang = true, nargs = 0, desc = 'CoC organize imports' }
            )

            -- shortcut for perttier to format javascript/css
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
        end,
        lazy = false,
    }
end
