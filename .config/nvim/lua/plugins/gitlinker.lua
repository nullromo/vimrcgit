-- get github/gitlab links from code using <Leader>gb

return function()
    return {
        'ruifm/gitlinker.nvim',
        config = function()
            require('gitlinker').setup({
                callbacks = {
                    ['gitlab.diconcloud.com'] = require('gitlinker.hosts').get_gitlab_type_url,
                },
                -- TODO: disabling the default mapping doesn't actually work (see https://github.com/ruifm/gitlinker.nvim/issues/48)
                mappings = nil,
            })

            -- Use <leader>gb to open a browser link to the current line
            vim.api.nvim_set_keymap(
                'n',
                '<leader>gb',
                "<cmd>lua require('gitlinker').get_buf_range_url('n', {action_callback = require('gitlinker.actions').open_in_browser})<cr>",
                { silent = true, desc = 'Gitlinker from normal mode' }
            )
            vim.api.nvim_set_keymap(
                'v',
                '<leader>gb',
                "<cmd>lua require('gitlinker').get_buf_range_url('v', {action_callback = require('gitlinker.actions').open_in_browser})<cr>",
                { desc = 'Gitlinker from visual mode' }
            )
        end,
    }
end
