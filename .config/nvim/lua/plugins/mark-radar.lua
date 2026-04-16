-- mark jumping highlighter

return function()
    return {
        'winston0410/mark-radar.nvim',
        config = function()
            require('mark-radar').setup({
                text_position = 'inline',
                pre_scan_hook = function()
                    require('ibl').update({ enabled = false })
                end,
                post_clean_up_hook = function()
                    require('ibl').update({ enabled = true })
                end,
            })
        end,
    }
end
