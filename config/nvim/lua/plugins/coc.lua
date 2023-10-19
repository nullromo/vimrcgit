return function()
    return {
        'neoclide/coc.nvim',
        branch = 'release',
        config = function ()
            -- ===
            -- COC
            -- ===
            -- Install CoC extensions when the service starts
            vim.g.coc_global_extensions = {'coc-tsserver', 'coc-json', 'coc-html', 'coc-css', 'coc-pyright', 'coc-git', 'coc-prettier', 'coc-eslint', 'coc-clangd', 'coc-webview', 'coc-markdown-preview-enhanced'}
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
        lazy = false,
    }
end
