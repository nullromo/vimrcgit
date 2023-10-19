return function()
    return {
        'preservim/nerdtree',
        init = function ()
            -- Close NERDTree when a file is opened
            vim.g.NERDTreeQuitOnOpen = 1
            -- Do not show bookmarks
            vim.g.NERDTreeShowBookmarks = 0
            -- Show files and hidden files in NREDTree
            vim.g.NERDTreeShowFiles = 1
            vim.g.NERDTreeShowHidden = 1
            -- Show line numbers in NERDTree
            vim.g.NERDTreeShowLineNumbers = 1
        end,
        event = 'VeryLazy',
    }
end
