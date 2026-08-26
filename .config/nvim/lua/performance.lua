return function()
    -- Helps the screen redraw
    vim.opt.ttyfast = true

    -- Pin the clipboard provider so it skips its candidate probe, which takes
    -- a long time (up to ~1.5s). provider/clipboard.vim calls executable() on
    -- various tools we may not have. NOTE: this must run before
    -- require('plugins')(), because nerdtree's fs_menu.vim calls
    -- has('clipboard') at source time, which resolves the provider. See
    -- init.lua for the initialization
    if vim.env.TMUX then
        -- Inside tmux: buffers work in both directions and `-w` forwards to
        -- the Windows clipboard via OSC 52. This is what the probe resolves to
        vim.g.clipboard = {
            name = 'tmux',
            copy = {
                ['+'] = { 'tmux', 'load-buffer', '-w', '-' },
                ['*'] = { 'tmux', 'load-buffer', '-w', '-' },
            },
            paste = {
                ['+'] = { 'tmux', 'save-buffer', '-' },
                ['*'] = { 'tmux', 'save-buffer', '-' },
            },
            cache_enabled = 0,
        }
    else
        -- Outside tmux fallback
        local osc52 = require('vim.ui.clipboard.osc52')
        local powershell_paste = {
            'sh',
            '-c',
            "powershell.exe -NoProfile -NoLogo -Command Get-Clipboard | tr -d '\\r'",
        }
        vim.g.clipboard = {
            name = 'osc52-copy/powershell-paste',
            copy = {
                ['+'] = osc52.copy('+'),
                ['*'] = osc52.copy('*'),
            },
            paste = {
                ['+'] = powershell_paste,
                ['*'] = powershell_paste,
            },
            cache_enabled = 0,
        }
    end

    -- Skip probing for language hosts that aren't installed
    vim.g.loaded_perl_provider = 0
    vim.g.loaded_ruby_provider = 0
end
