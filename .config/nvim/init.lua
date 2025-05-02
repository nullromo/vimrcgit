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
--require('lsp')()
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

-- plugin idea that is still a work in progress
require('ssss')()
