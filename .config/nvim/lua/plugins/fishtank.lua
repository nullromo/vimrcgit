-- screensaver

return function()
    return {
        'nullromo/fishtank.nvim',
        config = function()
            local fishtank = require('fishtank')
            fishtank.setup({
                screensaver = {
                    enabled = true,
                    timeout = 5 * 60 * 1000, -- 5 minutes
                },
                numberOfFish = 2,
                sprite = {
                    left = [[
      .:/
  ,,///;,   ,;/
 o:::::::;;///
>::::::::;;\\\
  ''\\\\\'" ';\
     ';\
]],
                    right = [[
       \:.
\;,   ,;\\\,,
 \\\;;:::::::o
 ///;;::::::::<
/;' "'/////''
       /;'
]],
                },
            })
        end,
    }
end
