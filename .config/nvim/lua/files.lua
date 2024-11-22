return function()
    -- Do not create swap files
    vim.opt.swapfile = false

    -- Do not create backup files
    vim.opt.backup = false

    -- Set encoding type
    vim.opt.encoding = 'utf-8'

    -- Try to make git not have a weird end-of-file issue
    vim.opt.fileformats = 'unix,dos,mac'

    -- Highlight Jenkinsfile as a Groovy script
    vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
        pattern = 'Jenkinsfile',
        command = 'set filetype=groovy',
        desc = 'set Jenkinsfile filetype',
    })

    -- Highlight system.config file as JSON
    vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
        pattern = 'system.config,*.gpdummyconfig,*.gp800systemdiagram',
        command = 'set filetype=json',
        desc = 'set system.config filetype',
    })

    -- Don't allow hidden modified buffers
    vim.opt.hidden = false

    -- Set up folds based on indentation
    vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
        pattern = '*',
        callback = function()
            vim.opt_local.foldmethod = 'indent'
        end,
        desc = 'Enable folding while not in insert mode',
    })
    vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
        pattern = '*',
        callback = function()
            vim.opt_local.foldmethod = 'manual'
        end,
        desc = 'Disable folding while in insert mode',
    })

    -- Open all folds by default
    vim.opt.foldlevelstart = 99
end
