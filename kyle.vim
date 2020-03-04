" reset all the syntax coloring
hi clear
set background=dark
if exists("syntax_on")
  syntax reset
endif

" assign this colorscheme a name
let g:colors_name = "kyle"

" all options from the syntax help document in the order they appear
hi ColorColumn  ctermbg=darkred
hi Conceal      cterm=NONE
hi Cursor       cterm=NONE
hi CursorIM     cterm=NONE
hi CursorColumn cterm=underline
hi CursorLine   cterm=reverse
hi Directory    cterm=bold ctermfg=brown
hi DiffAdd      cterm=NONE
hi DiffChange   cterm=NONE
hi DiffDelete   cterm=NONE
hi DiffText     cterm=NONE
hi ErrorMsg     cterm=bold ctermfg=grey ctermbg=darkred
hi VertSplit    ctermfg=lightgray
hi Folded       cterm=NONE
hi FoldColumn   cterm=NONE
hi SignColumn   cterm=NONE
hi LineNr       cterm=bold ctermfg=darkgreen
hi CursorLineNr cterm=NONE
hi MatchParen   ctermfg=white
hi ModeMsg      cterm=bold
hi MoreMsg      cterm=bold ctermfg=darkgreen
hi NonText      cterm=bold ctermfg=darkred
hi Normal       cterm=NONE
hi Pmenu        cterm=NONE ctermbg=darkmagenta
hi PmenuSel     cterm=NONE
hi PmenuSbar    cterm=NONE ctermfg=white
hi PmenuThumb   cterm=NONE
hi Question     cterm=bold ctermfg=darkgreen
hi Search       cterm=reverse ctermfg=white ctermbg=darkred
hi SpecialKey   cterm=bold ctermfg=darkred
hi SpellBad     ctermfg=darkred ctermbg=gray
hi SpellCap     cterm=NONE ctermbg=darkblue
hi SpellLocal   cterm=NONE ctermbg=darkcyan
hi SpellRare    cterm=NONE ctermbg=darkmagenta
hi StatusLine   cterm=bold ctermfg=lightblue ctermbg=darkcyan
hi StatusLineNC ctermfg=darkgray ctermbg=lightblue
hi TabLine      ctermfg=blue ctermbg=white
hi TabLineFill  ctermfg=white ctermbg=white
hi TabLineSel   cterm=bold ctermfg=lightblue ctermbg=darkcyan
hi Terminal     cterm=NONE
hi Title        cterm=bold ctermfg=darkgreen
hi Visual       cterm=reverse
hi VisualNOS    cterm=NONE
hi WarningMsg   term=standout cterm=bold ctermfg=darkred
hi WildMenu     cterm=NONE

" not sure where these are defined
hi Comment      term=bold cterm=bold ctermfg=darkgray
hi Constant     term=underline cterm=bold ctermfg=darkcyan
hi Error        term=reverse ctermfg=darkcyan ctermbg=black
hi Identifier   term=underline ctermfg=brown
hi Ignore       ctermfg=black ctermbg=black
hi PreProc      term=underline ctermfg=darkmagenta
hi Special      term=bold cterm=bold ctermfg=brown
hi Statement    term=bold cterm=bold ctermfg=yellow
hi Type         term=underline cterm=bold ctermfg=lightgreen
hi Todo         term=standout ctermfg=black ctermbg=darkcyan
hi Underlined   term=underline cterm=bold,underline ctermfg=lightblue

" links
hi link EndOfBuffer NonText
hi link IncSearch Visual
hi link QuickFixLine Search
hi link String Constant
hi link Character Constant
hi link Number Constant
hi link Boolean Constant
hi link Float Number
hi link Function Identifier
hi link Conditional Statement
hi link Repeat Statement
hi link Label Statement
hi link Operator Statement
hi link Keyword Statement
hi link Exception Statement
hi link Include PreProc
hi link Define PreProc
hi link Macro PreProc
hi link PreCondit PreProc
hi link StorageClass Type
hi link Structure Type
hi link Typedef Type
hi link Tag Special
hi link SpecialChar Special
hi link Delimiter Special
hi link SpecialComment Special
hi link Debug Special
