" reset all the syntax coloring
hi clear
set background=dark
if exists("syntax_on")
  syntax reset
endif

" assign this colorscheme a name
let g:colors_name = "kyle"

" define color constants
let statusLineBackground = '24'
let statusLineBackgroundNC = 'darkgray'

" options for vim in general (in the order they appear in the syntax help document)
hi ColorColumn  ctermbg=darkred
hi Conceal      cterm=NONE
hi Cursor       cterm=NONE
hi CursorIM     cterm=NONE
hi CursorColumn cterm=underline
hi CursorLine   cterm=reverse
hi Directory    ctermfg=brown
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
   hi link EndOfBuffer NonText
hi Normal       cterm=NONE
hi Pmenu        cterm=NONE ctermbg=23
hi PmenuSel     cterm=NONE
hi PmenuSbar    cterm=NONE ctermfg=white
hi PmenuThumb   cterm=NONE
hi Question     cterm=bold ctermfg=darkgreen
hi Search       ctermfg=white ctermbg=darkred
   hi link QuickFixLine Search
hi SpecialKey   cterm=bold ctermfg=darkred
hi SpellBad     cterm=NONE ctermfg=darkred ctermbg=white
hi SpellCap     cterm=NONE ctermbg=darkblue
hi SpellLocal   cterm=NONE ctermbg=darkcyan
hi SpellRare    cterm=NONE ctermbg=darkmagenta
execute 'hi StatusLine cterm=bold ctermfg=lightblue ctermbg=' . statusLineBackground
execute 'hi StatusLineNC ctermfg=' . statusLineBackgroundNC . ' ctermbg=lightblue'
execute 'hi StatusLineTerm cterm=bold ctermfg=lightblue ctermbg=' . statusLineBackground
execute 'hi StatusLineTermNC ctermfg=lightblue ctermbg=darkgray'
execute 'hi TabLine cterm=NONE ctermfg=white ctermbg=' . statusLineBackgroundNC
execute 'hi TabLineFill ctermfg=' . statusLineBackgroundNC
execute 'hi TabLineSel cterm=NONE ctermfg=lightblue ctermbg=' . statusLineBackground
hi Terminal     cterm=NONE
hi Title        cterm=bold ctermfg=darkgreen
hi Visual       cterm=reverse
   hi link IncSearch Visual
hi VisualNOS    cterm=NONE
hi WarningMsg   term=standout cterm=bold ctermfg=darkred
hi WildMenu     cterm=NONE

" code-specific colorings for syntax groups
hi Comment      ctermfg=darkgray
hi Constant     term=underline cterm=bold ctermfg=darkcyan
   hi link String Constant
   hi link Character Constant
   hi link Number Constant
      hi link Float Number
   hi link Boolean Constant
hi Error        term=reverse ctermfg=darkcyan ctermbg=black
hi Identifier   cterm=NONE ctermfg=brown
   hi link Function Identifier
hi Ignore       ctermfg=black ctermbg=black
hi PreProc      term=underline ctermfg=darkmagenta
   hi link Include PreProc
   hi link Define PreProc
   hi link Macro PreProc
   hi link PreCondit PreProc
hi Special      cterm=bold ctermfg=darkgreen
   hi link Tag Special
   hi link SpecialChar Special
   hi link Delimiter Special
   hi link SpecialComment Special
   hi link Debug Special
hi Statement    ctermfg=yellow
   hi link Conditional Statement
   hi link Repeat Statement
   hi link Label Statement
   hi link Operator Statement
   hi link Keyword Statement
   hi link Exception Statement
hi Type         ctermfg=lightgreen
   hi link StorageClass Type
   hi link Structure Type
   hi link Typedef Type
hi Todo         term=standout ctermfg=black ctermbg=darkcyan
hi Underlined   term=underline cterm=bold,underline ctermfg=lightblue

" python-specific colorings
hi pythonFunction        cterm=NONE ctermfg=green
hi pythonClassVar        cterm=NONE ctermfg=darkmagenta
hi pythonBuiltinFunc     cterm=NONE ctermfg=brown
hi pythonString          cterm=NONE ctermfg=darkgray
hi pythonFString         cterm=NONE ctermfg=darkgray
hi pythonStrInterpRegion cterm=NONE ctermfg=darkcyan
hi link pythonFunctionCall pythonFunction

" Colorings for the custom status line
execute 'hi StatusLineGitBranchName ctermfg=lightgreen ctermbg=' . statusLineBackground
execute 'hi StatusLineGitBranchNameNC ctermfg=lightgreen ctermbg=' . statusLineBackgroundNC
execute 'hi StatusLineFileName ctermfg=white ctermbg=' . statusLineBackground
execute 'hi StatusLineFileNameNC ctermfg=white ctermbg=' . statusLineBackgroundNC
execute 'hi StatusLineNumber ctermfg=green ctermbg=' . statusLineBackground
execute 'hi StatusLineNumberNC ctermfg=green ctermbg=' . statusLineBackgroundNC
execute 'hi StatusLinePercent ctermfg=yellow ctermbg=' . statusLineBackground
execute 'hi StatusLinePercentNC ctermfg=yellow ctermbg=' . statusLineBackgroundNC
execute 'hi StatusLineMeta ctermfg=black ctermbg=' . statusLineBackground
execute 'hi StatusLineMetaNC ctermfg=black ctermbg=' . statusLineBackgroundNC

" Color overrides for CoC
hi CocErrorSign ctermfg=yellow
hi CocInfoSign ctermfg=lightblue

" Color overrides for flash.nvim
hi link FlashBackdrop Comment
hi FlashMatch ctermfg=red ctermbg=black
    hi link FlashCurrent FlashMatch
hi FlashLabel ctermbg=lightgray ctermfg=black
