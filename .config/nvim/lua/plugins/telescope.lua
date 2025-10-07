-- searcher

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
            'nvim-telescope/telescope-symbols.nvim',
            'nullromo/telescope-box-drawing.nvim',
        },
        config = function()
            -- import stuff from telescope
            local telescope = require('telescope')
            local telescopeShortcuts =
                require('telescope-live-grep-args.shortcuts')
            local telescopeBuiltins = require('telescope.builtin')
            local telescopeState = require('telescope.state')
            local telescopeActionState = require('telescope.actions.state')
            local telescopeActionSet = require('telescope.actions.set')
            local telescopeThemes = require('telescope.themes')
            local telescopePickers = require('telescope.pickers')
            local telescopeFinders = require('telescope.finders')
            local telescopeSorters = require('telescope.sorters')
            local telescopeConfig = require('telescope.config')
            local telescopeActions = require('telescope.actions')

            -- function that scrolls the telescope preview window by 1 line up
            -- or down
            local scrollSingleLine = function(bufferNumber, down)
                local previewer = telescopeActionState.get_current_picker(
                    bufferNumber
                ).previewer
                local status = telescopeState.get_status(bufferNumber)
                if
                    type(previewer) ~= 'table'
                    or previewer.scroll_fn == nil
                    or status.preview_win == nil
                then
                    return
                end
                previewer:scroll_fn(down and 1 or -1)
            end

            -- mappings for scrolling the telescope preview window up and down
            local telescopeMappings = {
                ['<C-e>'] = function(bufferNumber)
                    scrollSingleLine(bufferNumber, true)
                end,
                ['<C-y>'] = function(bufferNumber)
                    scrollSingleLine(bufferNumber, false)
                end,
                ['<C-f>'] = telescopeActions.to_fuzzy_refine,
            }

            -- opens the selected item in a new tab (in applicable pickers) and
            -- resumes telescope
            local openFileInNewTab = function(bufferNumber)
                telescopeActionSet.select(bufferNumber, 'tab')
                vim.cmd('normal gT')
                vim.cmd('Telescope resume')
            end

            -- main telescope setup/config
            telescope.setup({
                defaults = {
                    mappings = {
                        -- use the scroll up and down mappings in insert and
                        -- normal modes
                        i = telescopeMappings,
                        n = telescopeMappings,
                    },
                },
                pickers = {
                    find_files = {
                        disable_devicons = true,
                        mappings = {
                            -- override the default <C-t> behavior in the
                            -- find_files function to open the file in a new tab
                            -- and switch back to the old tab to resume
                            -- telescope
                            i = {
                                ['<C-t>'] = openFileInNewTab,
                            },
                            n = {
                                ['<C-t>'] = openFileInNewTab,
                            },
                        },
                    },
                },
                extensions = {
                    live_grep_args = {
                        disable_devicons = true,
                    },
                    ['box-drawing'] = telescopeThemes.get_cursor({
                        layout_config = { height = 20, width = 40 },
                    }),
                },
            })

            -- only load the fzf extension if ripgrep is installed
            if vim.fn.executable('rg') == 1 then
                telescope.load_extension('fzf')
            else
                print(
                    "WARNING: ripgrep ('rg') is not installed, so fzf from telescope will not work."
                )
            end
            telescope.load_extension('live_grep_args')
            telescope.load_extension('hbac')
            telescope.load_extension('fidget')
            telescope.load_extension('box-drawing')

            -- use ,* to live grep for the word under the cursor
            vim.keymap.set('n', '<leader>*', function()
                telescopeShortcuts.grep_word_under_cursor({
                    -- ignore case
                    postfix = ' -i',
                })
            end, { desc = 'live grep under cursor from normal mode' })
            vim.keymap.set(
                'v',
                '<leader>*',
                telescopeShortcuts.grep_visual_selection,
                { desc = 'live grep under cursor from visual mode' }
            )

            -- use :Search to start telescope live_grep_args
            vim.api.nvim_create_user_command('Search', function()
                telescope.extensions.live_grep_args.live_grep_args({
                    vimgrep_arguments = {
                        'rg',
                        -- default required arguments
                        '--color=never',
                        '--no-heading',
                        '--with-filename',
                        '--line-number',
                        '--column',
                        '--smart-case',
                        -- additional argument to search through hidden files
                        '--hidden',
                    },
                })
            end, { bang = true, desc = 'telescope grep' })

            -- use :File to start telescope find_files
            vim.api.nvim_create_user_command(
                'File',
                telescopeBuiltins.find_files,
                { bang = true, desc = 'telescope find file' }
            )

            -- use :Gs to start telescope git_status
            vim.api.nvim_create_user_command(
                'Gs',
                telescopeBuiltins.git_status,
                { bang = true, desc = 'telescope git status' }
            )

            -- use :Help to search vim's help pages
            vim.api.nvim_create_user_command(
                'Help',
                telescopeBuiltins.help_tags,
                { bang = true, desc = 'telescope help' }
            )

            -- use :ColorMapSearch to search for tags in the colorscheme
            vim.api.nvim_create_user_command(
                'ColorMapSearch',
                telescopeBuiltins.highlights,
                { bang = true, desc = 'telescope highlights' }
            )

            -- use :Marks to search through vim's marks
            vim.api.nvim_create_user_command(
                'Marks',
                telescopeBuiltins.marks,
                { bang = true, desc = 'telescope marks' }
            )

            -- use :Registers to search through vim's registers
            vim.api.nvim_create_user_command(
                'Registers',
                telescopeBuiltins.registers,
                { bang = true, desc = 'telescope registers' }
            )

            -- use :Ts to resume telescope
            vim.api.nvim_create_user_command('Tr', function()
                telescopeBuiltins.resume()
                vim.api.nvim_feedkeys(
                    vim.api.nvim_replace_termcodes('<ESC>', true, false, true),
                    '',
                    false
                )
            end, { bang = true, desc = 'telescope resume' })

            local showSymbolsAndEmoji = function(sources)
                telescopeBuiltins.symbols(telescopeThemes.get_cursor({
                    layout_config = { height = 20 },
                    sources = sources,
                }))
            end

            -- use :Symbols and :Emoji to search through symbols and/or emoji
            vim.api.nvim_create_user_command('Emoji', function()
                showSymbolsAndEmoji({ 'emoji', 'gitmoji' })
            end, { desc = 'telescope emoji' })
            vim.api.nvim_create_user_command('Symbols', function()
                showSymbolsAndEmoji({ 'julia', 'math' })
            end, { desc = 'telescope symbols' })

            -- use :Hbac to search through hbac pin status
            vim.api.nvim_create_user_command('Hbac', function()
                telescope.extensions.hbac.buffers()
            end, { desc = 'hbac search' })

            local pickUnstagedGitHunks = function()
                telescopePickers
                    .new({
                        finder = telescopeFinders.new_oneshot_job(
                            { 'git', 'jump', '--stdout', 'diff' },
                            {
                                entry_maker = function(line)
                                    local filename, lineNumberString =
                                        line:match('([^:]+):(%d+).*')
                                    if filename:match('^/dev/null') then
                                        return nil
                                    end
                                    return {
                                        value = filename,
                                        display = line,
                                        ordinal = line,
                                        filename = filename,
                                        lnum = tonumber(lineNumberString),
                                    }
                                end,
                            }
                        ),
                        sorter = telescopeSorters.get_generic_fuzzy_sorter(),
                        previewer = telescopeConfig.values.grep_previewer({}),
                        results_title = 'Unstaged git hunks',
                        preview_title = 'Unstaged git hunks preview',
                        prompt_title = 'Search unstaged git hunks',
                        layout_strategy = 'flex',
                    }, {})
                    :find()
            end

            vim.api.nvim_create_user_command('Diff', function()
                pickUnstagedGitHunks()
            end, { desc = 'telescope unstaged git hunks' })

            vim.api.nvim_create_user_command('BoxDrawing', function()
                telescope.extensions['box-drawing']['box-drawing'](
                    telescopeThemes.get_cursor({
                        layout_config = { height = 20, width = 40 },
                    })
                )
            end, { desc = 'telescope box drawing characters' })
        end,
        event = 'VeryLazy',
    }
end
