return function()
    return {
        'folke/drop.nvim',
        config = function ()
            vim.api.nvim_create_autocmd({'VimEnter'}, {pattern = '*', callback =
                function()
                    require('drop').setup({
                        theme = {
                            symbols = {"*", "."},
                            colors = {"blue", "lightblue", "darkblue", "white", "lightgray"}
                        },
                        max = 170,
                        interval = 150,
                        screensaver = 1000 * 10 * 60,
                        filetypes = {},
                    })
                end
            })
        end,
        event = 'VeryLazy',
    }
end
