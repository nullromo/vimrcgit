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
            -- use C-f to activate flash during normal mode, operator pending mode, and visual mode
            vim.keymap.set({'n', 'o', 'x'}, '<C-f>', function() require('flash').jump() end)
            -- use r to activate remote flash in operator pending mode
            vim.keymap.set({'o'}, 'r', function() require('flash').remote() end)
        end,
        --keys = {
            --{ "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            --{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        --},
        event = 'VeryLazy',
    }
end
