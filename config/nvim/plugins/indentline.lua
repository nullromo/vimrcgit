return function()
    return {
        'yggdroot/indentline',
        init = function ()
            -- Set the color
            vim.g.indentLine_color_term = 'brown'
            -- Set the character
            vim.g.indentLine_char = '|'
            -- Do not use in json or help files
            --   NOTE: since this plugin uses vim's conceal feature, and that messes up
            --   JSON quotes, it doens't really work in json files or markdown
            vim.g.indentLine_fileTypeExclude = {'json', 'jsonc', 'help', 'markdown', 'markdown.mdx'}
        end,
    }
end
