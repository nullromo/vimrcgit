-- core utility for language server functionality

-- language parsers to install
-- NOTE: jsonc is deliberately absent. The main branch has no jsonc parser and
-- instead maps the jsonc filetype onto the json parser (plugin/filetypes.lua).
local languages = {
    -- required defaults
    'c',
    'lua',
    'vim',
    'vimdoc',
    'query',
    -- additional languages
    'bash',
    'cmake',
    'cpp',
    'css',
    'csv',
    'diff',
    'dockerfile',
    'doxygen',
    'git_config',
    'git_rebase',
    'gitcommit',
    'gitignore',
    'html',
    'http',
    'javascript',
    'jsdoc',
    'json',
    'luadoc',
    'make',
    'markdown',
    'markdown_inline',
    'python',
    'regex',
    'sql',
    'ssh_config',
    'toml',
    'tsx',
    'typescript',
    'xml',
    'yaml',
    'yang',
}

return function()
    return {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        -- the main branch does not support lazy-loading
        lazy = false,
        build = ':TSUpdate',
        config = function()
            local treesitter = require('nvim-treesitter')

            -- parsers and queries are installed here, and this directory is
            -- prepended to the runtimepath so it takes priority
            treesitter.setup({
                install_dir = vim.fn.stdpath('data') .. '/site',
            })

            -- no-op once the parsers are present, so this is safe on startup
            treesitter.install(languages)

            vim.api.nvim_create_autocmd({ 'FileType' }, {
                desc = 'Enable treesitter highlighting and indentation',
                callback = function(args)
                    local filetype = vim.bo[args.buf].filetype
                    local language = vim.treesitter.language.get_lang(filetype)
                    -- language.add() returns nil when no parser is installed
                    if
                        not language
                        or not vim.treesitter.language.add(language)
                    then
                        return
                    end

                    vim.treesitter.start(args.buf, language)

                    -- only take over indenting for languages that actually
                    -- have an indents query
                    if vim.treesitter.query.get(language, 'indents') then
                        vim.bo[args.buf].indentexpr =
                            "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })

            -- for some reason, treesitter seems to be hiding some text in help
            -- files. The conceallevel is set to 2 from vim itself, but for
            -- some reason the text is the same color as the background. One
            -- way around this is to just set conceallevel to 0
            vim.api.nvim_create_autocmd({ 'FileType' }, {
                pattern = 'help',
                command = 'set conceallevel=0',
                desc = 'Do not conceal help',
            })
        end,
    }
end
