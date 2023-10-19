return function()
    return {
        'folke/flash.nvim',
        event = 'VeryLazy',
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
                    autohide = true,
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
        keys = {
            -- use C-f to activate flash during normal mode, operator pending mode, and visual mode
            { "<C-f>", mode = { "n", "o", "x" }, function() require("flash").jump() end, desc = "Flash" },
            --{ "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            -- use r to activate flash in operator pending mode
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            --{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        },
    }
end
