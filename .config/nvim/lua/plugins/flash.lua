return function()
    return {
        'folke/flash.nvim',
        opts = {
            label = {
                -- only use lowercase letters for jump labels
                uppercase = false,
                -- use <CR> as the first label
                current = false,
                -- position the labels at the beginning of the search words
                after = false,
                before = true,
            },
            highlight = {
                backdrop = false,
            },
            modes = {
                search = {
                    enabled = false,
                },
                char = {
                    autohide = false,
                    search = {
                        wrap = true,
                    },
                    highlight = {
                        backdrop = false,
                        matches = false,
                        groups = {
                            label = "FlashMatch",
                        },
                    },
                },
            },
            remote_op = {
                motion = true,
            },
        },
        config = function(_, opts)
            require('flash').setup(opts)
            vim.keymap.set({'n', 'o', 'x'}, '<C-f>', function() require('flash').jump() end)
            vim.keymap.set({'o'}, 'r', function() require('flash').remote() end)
        end,
        --keys = {
            -- use C-f to activate flash during normal mode, operator pending mode, and visual mode
            --{ "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            -- use r to activate flash in operator pending mode
            --{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        --},
        --keys = {
            --{
                --'<C-f>',
                --mode = {'n', 'o', 'x'},
            --},
            --{
                --'r',
                --mode = {'o', 'x'},
            --},
        --},
        event = 'VeryLazy',
    }
end
