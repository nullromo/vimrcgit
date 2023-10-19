return function()
    -- Show mode in bottom-left corner
    vim.opt.showmode = true
    -- Show partial command in bottom right corner
    vim.opt.showcmd = true
    -- Toggle the ruler on or off
    vim.api.nvim_create_user_command('Ruler', 'set colorcolumn=81', {bang = true})
    vim.api.nvim_create_user_command('Noruler', 'set colorcolumn=', {bang = true})
    -- Resize the window (when not maximized)
    vim.keymap.set('n', '<S-Left>', ':set columns-=10<CR>')
    vim.keymap.set('n', '<S-Right>', ':set columns+=10<CR>')
    vim.keymap.set('n', '<S-Up>', ':set lines-=5<CR>')
    vim.keymap.set('n', '<S-Down>', ':set lines+=5<CR>')
    -- Show search messages ([X/Y] in bottom right for match X of Y)
    vim.cmd('set shortmess-=s')
    vim.cmd('set shortmess-=S')
    -- Set the cursor for neovim
    vim.opt.guicursor = 'n-o-i-c:hor25-blinkwait100-blinkoff500-blinkon500'
    -- Make the cursor always a blinking underscore NOTE: add `printf '\033[3 q'` to
    -- bashrc to make the cursor work in terminal windows
    vim.cmd([[
        let &t_SI .= "\<Esc>[3 q"
        let &t_SR .= "\<Esc>[3 q"
        let &t_EI .= "\<Esc>[3 q"
    ]])
end
