return function()
    -- Do not create swap files
    vim.opt.swapfile = false
    -- Do not create backup files
    vim.opt.backup = false
    -- Set encoding type
    vim.opt.encoding = 'utf-8'
    -- Highlight Jenkinsfile as a Groovy script
    vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {pattern = 'Jenkinsfile', command = 'set filetype=groovy'})
    -- Highlight system.config file as JSON
    vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {pattern = 'system.config', command = 'set filetype=json'})
end