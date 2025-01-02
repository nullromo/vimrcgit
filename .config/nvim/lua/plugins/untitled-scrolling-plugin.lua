return function()
    -- Should make this into a plugin and enhance the functionality. See this
    -- stack overflow answer for more details:
    -- https://vi.stackexchange.com/a/46175/25982

    local untitledScrollingPluginExtmarkNamespace =
        vim.api.nvim_create_namespace('untitledScrollingPluginExtmarkNamespace')

    local setUpExtmarks = function()
        for line = 1, 100 do
            local id = vim.api.nvim_buf_set_extmark(
                0,
                untitledScrollingPluginExtmarkNamespace,
                0,
                0,
                {
                    id = line,
                    virt_lines = { { { '-' .. line - 1, 'Comment' } } },
                    virt_lines_above = true,
                }
            )
        end
    end

    vim.api.nvim_create_autocmd('BufEnter', {
        callback = function()
            setUpExtmarks()
        end,
    })
end
