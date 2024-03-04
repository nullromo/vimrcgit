-- Remove all autocommands to prevent duplicates on vimrc reload
vim.api.nvim_clear_autocmds({})
-- Disable vi compatibility
vim.opt.compatible = false
-- Use , as the leader key
vim.g.mapleader = ','
-- Use this for WSL default terminal emulator (non wsltty)
-- https://vi.stackexchange.com/questions/28269/command-already-typed-in-when-i-open-vim
--vim.cmd("set t_u7=")

-- Third-party plugins
require('plugins')()

-- Subsections of vim configuration
require('autoformatting')()
require('statusline')()
require('colors')()
require('typing')()
require('mouse')()
require('searching')()
require('gui-elements')()
require('netrw')()
require('performance')()
require('key-mappings')()
require('files')()
require('general')()
require('commands')()

-- TODO: turn this into a plugin
-- possible names:
--   shades.nvim: putting on shades to dim lines or turning lines into ghosts
--   check-off.nvim/checkoff.nvim/checkov.nvim/checklist.nvim: checking things off
--   cover-up.nvim: hiding lines
--   mask.nvim: mask off certain lines (except it doesn't really do that)
-- for now it's called 'ssss' as a placeholder
-- TODO: deal with multiple buffers
-- TODO: the hiddenLines doesn't work when the buffer is modified and lines are added
-- TODO: jumping should skip a whole block of connected hidden lines, not just go to the next single line

-- extmark namespace
local ssssNamespace = vim.api.nvim_create_namespace('ssss')

-- constants
local waveBlue2 = '#2D4F67'
local sumiInk0 = '#16161D'

-- highlight groups
vim.cmd.highlight('SSSSShaded', 'guibg=' .. sumiInk0 .. ' guifg=' .. waveBlue2)
vim.cmd.highlight('SSSSSign', 'guifg=' .. waveBlue2)

-- track extmarks
local hiddenLines = {}

-- options
ssssOptions = {
    signText = '',
    --signText = ' x',
    --signText = '😎',
    --signText = '🕶️',
}

-- ssss line
local ssssLine = function(line)
    -- see if the line is already highlighted
    if hiddenLines[line] then
        -- if the line is already highlighted, then do nothing
        return
    end

    -- set up an extmark for the new highlight
    local markID = vim.api.nvim_buf_set_extmark(0, ssssNamespace, line - 1, 0, {
        sign_text = ssssOptions.signText,
        sign_hl_group = 'SSSSSign',
        line_hl_group = 'SSSSShaded',
    })

    -- track the new extmark
    hiddenLines[line] = markID

    ---- debug printout
    --for k, v in pairs(hiddenLines) do
    --vim.notify(k .. ': ' .. v)
    --end
end

-- ssss multiple lines
local ssssLines = function(startLine, endLine)
    for line = startLine, endLine, 1 do
        ssssLine(line)
    end
end

-- un-ssss line
local unSSSSLine = function(line)
    -- find extmark for lines
    local markID = hiddenLines[line]

    -- if there is no mark, do nothing
    if markID == nil then
        return
    end

    -- delete the extmark
    vim.api.nvim_buf_del_extmark(0, ssssNamespace, markID)

    -- remove the extmark from the table
    hiddenLines[line] = nil

    ---- debug printout
    --for k, v in pairs(hiddenLines) do
    --vim.notify(k .. ': ' .. v)
    --end
end

-- un-ssss multiple lines
local unSSSSLines = function(startLine, endLine)
    for line = startLine, endLine, 1 do
        unSSSSLine(line)
    end
end

-- ssss user command
vim.api.nvim_create_user_command('SSSSHide', function(args)
    ssssLines(args.line1, args.line2)
end, { range = true, desc = 'SSSS lines' })

-- un-ssss user command
vim.api.nvim_create_user_command('SSSSUnhide', function(args)
    unSSSSLines(args.line1, args.line2)
end, { range = true, desc = 'Un-SSSS lines' })

-- find next ssss'd section
local findSSSS = function(forward)
    local currentLine = vim.fn.line('.')
    local maxLines = vim.fn.line('$')
    local jump = nil
    for i = 1, maxLines, 1 do
        -- for forward, use i; for backward, use (maxLines - i)
        local line = forward and (((i + currentLine - 1) % maxLines) + 1)
            or (((maxLines - i + currentLine - 1) % maxLines) + 1)
        if hiddenLines[line] ~= nil then
            jump = line
            break
        end
    end
    if jump == nil then
        return
    end

    -- jump to new position
    vim.cmd('normal ' .. jump .. 'G')
end

-- find next ssss section user command
vim.api.nvim_create_user_command('SSSSNext', function()
    findSSSS(true)
end, { desc = 'Find next SSSS' })

-- find previous ssss section user command
vim.api.nvim_create_user_command('SSSSPrevious', function()
    findSSSS(false)
end, { desc = 'Find prev SSSS' })

-- set keymaps
vim.keymap.set({ 'n', 'v' }, '<Leader>s', ':SSSSHide<CR>', { desc = 'SSSS' })
vim.keymap.set(
    { 'n', 'v' },
    '<Leader>a',
    ':SSSSUnhide<CR>',
    { desc = 'un-SSSS' }
)
vim.keymap.set('n', ']a', ':SSSSNext<CR>', { desc = 'SSSS next' })
vim.keymap.set('n', '[a', ':SSSSPrevious<CR>', { desc = 'SSSS next' })
