return function()
    return {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    -- only run if make is available
                    return vim.fn.executable('make') == 1
                end,
            },
            'nvim-telescope/telescope-live-grep-args.nvim',
        },
        config = function()
            require('telescope').setup()
            -- only load the fzf extension if ripgrep is installed
            if (vim.fn.executable('rg') == 1) then
                require('telescope').load_extension('fzf')
            else
                print("WARNING: ripgrep ('rg') is not installed, so fzf from telescope will not work.")
            end
            require('telescope').load_extension('live_grep_args')

            -- use ,* to live grep for the word under the cursor
            vim.keymap.set('n', '<leader>*', function()
                require('telescope-live-grep-args.shortcuts').grep_word_under_cursor({
                    -- ignore case
                    postfix = ' -i',
                })
            end)
            vim.keymap.set('v', '<leader>*', require('telescope-live-grep-args.shortcuts').grep_visual_selection)
        end,
        event = 'VeryLazy',
    }
end
