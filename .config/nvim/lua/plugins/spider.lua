return function()
    local motionFromInsertMode = require('util').motionFromInsertMode

    -- delete a keymap, but ignore the error message that there was no keymap
    -- to delete
    local silentKeymapDelete = function(modes, lhs, opts)
        local ok, result = pcall(function()
            vim.keymap.del(modes, lhs, opts)
        end)
        local errorMessage = '' .. (result or '')
        -- if there was an error and it did not contain the string 'No such
        -- mapping', then notify the error
        if not ok and not string.find(errorMessage, 'No such mapping') then
            vim.notify(errorMessage)
        end
    end

    local addSpiderMappings = function()
        -- map w, e, b, and ge for normal and visual modes only. W, E, B, and gE
        -- function normally
        vim.keymap.set(
            { 'n', 'x' },
            'w',
            "<cmd>lua require('spider').motion('w')<CR>",
            { desc = 'Spider w motion' }
        )
        vim.keymap.set(
            { 'n', 'x' },
            'e',
            "<cmd>lua require('spider').motion('e')<CR>",
            { desc = 'Spider e motion' }
        )
        vim.keymap.set(
            { 'n', 'x' },
            'b',
            "<cmd>lua require('spider').motion('b')<CR>",
            { desc = 'Spider b motion' }
        )
        vim.keymap.set(
            { 'n', 'x' },
            'ge',
            "<cmd>lua require('spider').motion('ge')<CR>",
            { desc = 'Spider ge motion' }
        )

        -- use <C-w>, <C-b>, and <C-g>e in insert mode to mimic normal mode w,
        -- b, and ge. Insert mode <C-e> already has a use (copies the charater
        -- from the line below)
        silentKeymapDelete('i', '<C-w>')
        vim.keymap.set(
            'i',
            '<C-w>',
            "<cmd>lua require('spider').motion('w')<CR>",
            { desc = 'Spider insert mode w motion' }
        )
        silentKeymapDelete('i', '<C-b>')
        vim.keymap.set(
            'i',
            '<C-b>',
            "<cmd>lua require('spider').motion('b')<CR>",
            { desc = 'Spider insert mode b motion' }
        )
        silentKeymapDelete('i', '<C-g>e')
        vim.keymap.set(
            'i',
            '<C-g>e',
            "<cmd>lua require('spider').motion('ge')<CR>",
            { desc = 'Spider insert mode ge motion' }
        )
    end

    local removeSpiderMappings = function()
        silentKeymapDelete({ 'n', 'x' }, 'w')
        silentKeymapDelete({ 'n', 'x' }, 'e')
        silentKeymapDelete({ 'n', 'x' }, 'b')
        silentKeymapDelete({ 'n', 'x' }, 'ge')
        silentKeymapDelete('i', '<C-w>')
        vim.keymap.set('i', '<C-w>', function()
            return motionFromInsertMode('w')
        end, { expr = true, desc = 'Insert mode w motion' })
        silentKeymapDelete('i', '<C-b>')
        vim.keymap.set('i', '<C-b>', function()
            return motionFromInsertMode('b')
        end, { expr = true, desc = 'Insert mode b motion' })
        silentKeymapDelete('i', '<C-g>e')
        vim.keymap.set('i', '<C-g>e', function()
            return motionFromInsertMode('ge')
        end, { expr = true, desc = 'Insert mode ge motion' })
    end

    -- initialize with spider mode disabled
    local spiderModeEnabled = false
    -- call removeSpiderMappings to set up the non-spider mode mappings for <C-w>, <C-b>, etc.
    removeSpiderMappings()

    return {
        'chrisgrieser/nvim-spider',
        enable = false,
        event = 'VeryLazy',
        config = function()
            require('spider').setup({
                skipInsignificantPunctuation = false,
            })

            -- create user commands to turn spider on and off
            vim.api.nvim_create_user_command('SpiderEnable', function()
                if spiderModeEnabled then
                    vim.notify('Spider already enabled')
                else
                    spiderModeEnabled = true
                    addSpiderMappings()
                    vim.notify('Spider enabled')
                end
            end, { bang = true, desc = 'Enable spider' })
            vim.api.nvim_create_user_command('SpiderDisable', function()
                if spiderModeEnabled then
                    spiderModeEnabled = false
                    removeSpiderMappings()
                    vim.notify('Spider disabled')
                else
                    vim.notify('Spider already disabled')
                end
            end, { bang = true, desc = 'Disable spider' })
            vim.api.nvim_create_user_command('SpiderToggle', function()
                if spiderModeEnabled then
                    spiderModeEnabled = false
                    removeSpiderMappings()
                    vim.notify('Spider disabled')
                else
                    spiderModeEnabled = true
                    addSpiderMappings()
                    vim.notify('Spider enabled')
                end
            end, { bang = true, desc = 'Toggle spider' })

            -- use <C-S-w>, <C-S-e>, <C-S-b>, and <C-g>E in insert mode to mimic
            -- normal mode W, E, B, and gE. These are not really part of
            -- spider.nvim, but they are configured here because they are
            -- closely related
            vim.keymap.set('i', '<C-S-w>', function()
                return motionFromInsertMode('W')
            end, { expr = true, desc = 'Insert mode W motion' })
            vim.keymap.set('i', '<C-S-e>', function()
                return motionFromInsertMode('E')
            end, { expr = true, desc = 'Insert mode E motion' })
            vim.keymap.set('i', '<C-S-b>', function()
                return motionFromInsertMode('B')
            end, { expr = true, desc = 'Insert mode B motion' })
            vim.keymap.set('i', '<C-g>E', function()
                return motionFromInsertMode('gE')
            end, { expr = true, desc = 'Insert mode gE motion' })
        end,
    }
end
