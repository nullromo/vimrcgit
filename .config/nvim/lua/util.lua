return {
    -- when exiting insert mode, the cursor moves back 1 space. Insert mode
    -- mappings that need to exit insert mode have to begin with an l motion to
    -- counteract this. However, if the cursor is in column 1, then the l is not
    -- necessary and may cause problems
    motionFromInsertMode = function(motion)
        -- check if the cursor is in the first column
        if vim.fn.col('.') == 1 then
            return '<ESC>' .. motion .. 'i'
        end
        return '<ESC>l' .. motion .. 'i'
    end,
}
