hi clear

set background=dark

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "kyle"

hi Normal         cterm=NONE
hi Scrollbar      cterm=NONE
hi Menu           cterm=NONE
hi SpecialKey     term=bold cterm=bold ctermfg=darkred
hi NonText        term=bold cterm=bold ctermfg=darkred
hi Directory      term=bold cterm=bold ctermfg=brown
hi ErrorMsg       term=standout cterm=bold ctermfg=grey ctermbg=darkred
hi Search         term=reverse ctermfg=white ctermbg=darkred
hi MoreMsg        term=bold cterm=bold ctermfg=darkgreen
hi ModeMsg        term=bold cterm=bold
hi LineNr         term=underline cterm=bold ctermfg=darkgreen
hi Question       term=standout cterm=bold ctermfg=darkgreen
hi StatusLine     term=bold,reverse cterm=bold ctermfg=lightblue ctermbg=darkcyan
hi StatusLineNC   term=reverse ctermfg=darkgray ctermbg=lightblue
hi Title          term=bold cterm=bold ctermfg=darkgreen
hi Visual         term=reverse cterm=reverse
hi WarningMsg     term=standout cterm=bold ctermfg=darkred
hi Cursor         cterm=NONE
hi Comment        term=bold cterm=bold ctermfg=cyan
hi Constant       term=underline cterm=bold ctermfg=darkcyan
hi Special        term=bold cterm=bold ctermfg=brown
hi Identifier     term=underline ctermfg=cyan
hi Statement      term=bold cterm=bold ctermfg=yellow
hi PreProc        term=underline ctermfg=darkmagenta
hi Type           term=underline cterm=bold ctermfg=lightgreen
hi Error          term=reverse ctermfg=darkcyan ctermbg=black
hi Todo           term=standout ctermfg=black ctermbg=darkcyan
hi CursorLine     cterm=NONE ctermbg=darkgray
hi CursorColumn   term=underline cterm=underline
hi MatchParen     term=reverse ctermfg=blue
hi TabLine        term=bold ctermfg=blue ctermbg=white
hi TabLineFill    ctermfg=white ctermbg=white
hi TabLineSel     term=reverse cterm=bold ctermfg=lightblue ctermbg=darkcyan
hi Underlined     term=underline cterm=bold,underline ctermfg=lightblue
hi Ignore         ctermfg=black ctermbg=black
hi SpellBad       ctermfg=darkred ctermbg=gray
hi ColorColumn    ctermbg=darkred

hi link IncSearch               Visual
hi link String                  Constant
hi link Character               Constant
hi link Number                  Constant
hi link Boolean                 Constant
hi link Float                   Number
hi link Function                Identifier
hi link Conditional             Statement
hi link Repeat                  Statement
hi link Label                   Statement
hi link Operator                Statement
hi link Keyword                 Statement
hi link Exception               Statement
hi link Include                 PreProc
hi link Define                  PreProc
hi link Macro                   PreProc
hi link PreCondit               PreProc
hi link StorageClass            Type
hi link Structure               Type
hi link Typedef                 Type
hi link Tag                     Special
hi link SpecialChar             Special
hi link Delimiter               Special
hi link SpecialComment          Special
hi link Debug                   Special
