return function()
    -- Use tree layout by default
    vim.g.netrw_liststyle = 3
    -- Hide the banner
    vim.g.netrw_banner = 0
    -- Use default width of 40 columns
    vim.g.netrw_winsize = 20
    -- Open files in the netrw window
    vim.g.netrw_browse_split = 0
    -- Use the :Tree command to open netrw in Vim's working directory
    vim.api.nvim_create_user_command('Tree', ":execute 'Vexplore' getcwd()",
        { bang = true, nargs = 0, desc = 'open netrw tree' }
    )
end
