return function()
    -- Do not create swap files
    vim.opt.swapfile = false

    -- Do not create backup files
    vim.opt.backup = false

    -- Set encoding type
    vim.opt.encoding = 'utf-8'

    -- Try to make git not have a weird end-of-file issue
    vim.opt.fileformats = 'unix,dos,mac'

    -- Set filetype (and highlighting) for certain files
    local filetypeMap = {
        { pattern = 'Jenkinsfile', filetype = 'groovy' },
        {
            pattern = 'system.config,*.gpdummyconfig,*.gp800systemdiagram',
            filetype = 'json',
        },
        { pattern = '*.rules', filetype = 'udevrules' },
        { pattern = '*.service', filetype = 'systemd' },
    }

    for _, config in ipairs(filetypeMap) do
        vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
            pattern = config.pattern,
            command = 'set filetype=' .. config.filetype,
            desc = 'set ' .. config.pattern .. ' filetype',
        })
    end

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
