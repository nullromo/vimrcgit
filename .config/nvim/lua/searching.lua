return function()
    -- Ignore case in searches
    vim.opt.ignorecase = true
    -- Highlight searches
    vim.opt.hlsearch = true
    -- Show search matches as the search is being typed
    vim.opt.incsearch = true
    -- Use clc in command mode to clear the search
    vim.keymap.set('c', 'clc<CR>', 'let @/ = ""<CR>')
    -- Use // in visual mode to search for what is highlighted
    vim.keymap.set('v', '//', 'y/<C-R>"<CR>')
    -- Make commands apply to all lines (global) by default
    vim.opt.gdefault = true
    -- Show filepath completion in status line
    vim.opt.wildmenu = true
    -- Add terms to the current search with + (NOTE: the normal mapping for + is
    -- just moving between lines)
    vim.keymap.set('n', '+', '/<C-r>/\\|')
end
