-- Remove all autocommands to prevent duplicates on vimrc reload
vim.api.nvim_clear_autocmds({})
-- Disable vi compatibility
vim.opt.compatible = false
-- Use , as the leader key
vim.g.mapleader = ','
-- Use this for WSL default terminal emulator (non wsltty)
-- https://vi.stackexchange.com/questions/28269/command-already-typed-in-when-i-open-vim
--vim.cmd("set t_u7=")

-- shortmess+=I must be set before plugins load to prevent the intro screen
-- from appearing
vim.opt.shortmess:append('I')

-- performance must initialize before plugins because nerdtree's fs_menu.vim
-- calls has('clipboard') at source time, which resolves the clipboard
-- provider. If g:clipboard isn't pinned by then, the provider runs its full
-- probe and costs ~1.5s. See lua/performance.lua for details
require('performance')()

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
require('key-mappings')()
require('files')()
require('general')()
require('commands')()

-- plugin idea that is still a work in progress
require('ssss')()
