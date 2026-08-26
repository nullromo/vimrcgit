-- integrate lazygit into vim

return function()
    return {
        'kdheepak/lazygit.nvim',
        -- only load when a lazygit command is run.
        cmd = {
            'Lg',
            'LazyGit',
            'LazyGitConfig',
            'LazyGitCurrentFile',
            'LazyGitFilter',
            'LazyGitFilterCurrentFile',
            'LazyGitLog',
        },
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local lazygit = require('lazygit')
            vim.api.nvim_create_user_command('Lg', function()
                lazygit.lazygit()
            end, { desc = 'Launch LazyGit' })
            vim.g.lazygit_floating_window_use_plenary = 1
            if vim.fn.has('nvim') and vim.fn.executable('nvr') then
                vim.cmd([[
                    let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
                ]])
            end
        end,
    }
end
