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
end
