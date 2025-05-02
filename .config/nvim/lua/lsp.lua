return function()
    -- configure defaults for all languages
    vim.lsp.config('*', {
        root_markers = { '.git' },
    })

    -- configure lua
    vim.lsp.config('lua', {
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
        root_markers = { '.luarc.json', '.luarc.jsonc' },
        settings = { Lua = { runtime = { version = 'LuaJIT' } } },
    })

    -- configure typescript
    -- install with `sudo npm install -g typescript-language-server typescript`
    vim.lsp.config('typescript', {
        cmd = { 'typescript-language-server', '--stdio' },
        filetypes = { 'typescript', 'typescriptreact' },
        root_markers = { 'package.json' },
        settings = {},
    })

    -- enable LSP
    vim.lsp.enable({ 'lua', 'typescript' })

    -- set autocomplete behavior.
    --   fuzzy = fuzzy search in results
    --   menuone = show menu, even if there is only 1 item
    --   popup = show extra info in popup
    --   noselect = don't insert the text until an item is selected
    vim.cmd('set completeopt=fuzzy,menuone,popup,noselect')

    -- set up stuff when the LSP client attaches
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp', {}),
        callback = function(args)
            local client = assert(
                vim.lsp.get_client_by_id(args.data.client_id),
                'Failed to get LSP client'
            )

            -- enable autocomplete
            if client:supports_method('textDocument/completion') then
                local chars = { '.', '"', "'", '/', '@', '<' }
                for i = 65, 90 do -- A-Z
                    table.insert(chars, string.char(i))
                end
                for i = 97, 122 do -- a-z
                    table.insert(chars, string.char(i))
                end
                client.server_capabilities.completionProvider.triggerCharacters =
                    chars
                vim.lsp.completion.enable(
                    true,
                    client.id,
                    args.buf,
                    { autotrigger = true }
                )
            end

            -- enable semantic token highlighting
            --vim.lsp.semantic_tokens.start(0, clientID)
        end,
    })

    -- open autocomplete menu when pressing <C-n>
    vim.keymap.set('i', '<C-n>', function()
        vim.lsp.completion.get()
    end)

    vim.lsp.inlay_hint.enable(true, nil)

    -- PROBLEMS
    -- don't know what inlay hints does
    -- semantic token highlighting doesn't work
    -- popup autocomplete extra info doesn't work
    -- completions when typing ( don't work
    -- autocomplete stops after backspace
end
