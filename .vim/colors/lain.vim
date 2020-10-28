let g:colors_name = "test"
set background=dark " hi or light

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

" Editor settings
hi Normal                 guifg=#d0c0d0
hi clear Cursor            " hi Cursor            term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi CursorLine                                                                                                                     guifg=#767676    guibg=#ff0000
hi LineNr                                                                                                                         guifg=#767676
hi clear CursorLineNR      " hi CursorLineNR      term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
"hi CursorLineNR                                                                                                                   guifg=#767676    guibg=#ff0000

" Number column
hi clear CursorColumn      " hi CursorColumn      term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear FoldColumn        " hi FoldColumn        term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear SignColumn        " hi SignColumn        term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear Folded            " hi Folded            term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none

" Window/Tab delimiters
hi VertSplit cterm=bold guifg=#000000    guibg=#2B2D4D
hi clear ColorColumn       " hi ColorColumn       term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi TabLine                                                                                                       gui=none         guifg=#a9b1d6    guibg=#2B2D4D
hi clear TabLineFill       " hi TabLineFill       term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi TabLineSel                                                                                                    gui=bold         guifg=#00ffff    guibg=#0000ff

" File Navigation / Searching
hi clear Directory         " hi Directory         term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi Search                                                                                                                         guifg=#ffff00    guibg=#0000ff
"hi Search                                                                                                                         guifg=#0000ff    guibg=#ffff00
hi clear IncSearch         " hi IncSearch         term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none

" Prompt/Status
hi StatusLine                                                     cterm=bold                                                      guifg=#00ffff    guibg=#0000ff
hi StatusLineNC                                                   cterm=none                                                      guifg=#a9b1d6    guibg=#2B2D4D
hi clear StatusLineTerm    " hi StatusLineTerm    term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear StatusLineTermNC  " hi StatusLineTermNC  term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear WildMenu          " hi WildMenu          term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear Question          " hi Question          term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear Title             " hi Title             term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear ModeMsg           " hi ModeMsg           term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear MoreMsg           " hi MoreMsg           term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none

" Visual aid
hi clear MatchParen        " hi MatchParen        term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi Visual term=reverse guifg=#1a2124 guibg=#00ffff
hi clear VisualNOS         " hi VisualNOS         term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear NonText           " hi NonText           term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear Todo              " hi Todo              term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear Underlined        " hi Underlined        term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear Error             " hi Error             term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear ErrorMsg          " hi ErrorMsg          term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear WarningMsg        " hi WarningMsg        term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear Ignore            " hi Ignore            term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear SpecialKey        " hi SpecialKey        term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none

" Variable types
hi clear Constant          " hi Constant          term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear String            " hi String            term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi String                                         ctermfg=115 guifg=#5fdfaf
hi clear StringDelimiter   " hi StringDelimiter   term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear Character         " hi Character         term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear Number            " hi Number            term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear Boolean           " hi Boolean           term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear Float             " hi Float             term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi Identifier                                                     cterm=bold                                                      guifg=#556a92
hi Function                                       cterm=bold                                                                      guifg=#875fff

" Language constructs
hi Statement                                                      cterm=bold                                                      guifg=#cc3080
hi clear Conditional       " hi Conditional       term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear Repeat            " hi Repeat            term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear Label             " hi Label             term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi Operator                                                       cterm=bold      ctermfg=166                                                     guifg=#ff5f00
hi Keyword                                                        cterm=bold                                                      guifg=#5fdf00
hi clear Exception         " hi Exception         term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi Comment                                                        cterm=bold                                                      guifg=#616f73
hi clear Special           " hi Special           term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear SpecialChar       " hi SpecialChar       term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear Tag               " hi Tag               term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear Delimiter         " hi Delimiter         term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear SpecialComment    " hi SpecialComment    term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear Debug             " hi Debug             term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none

" C like
hi PreProc                                                        cterm=bold                                                      guifg=#556a92
hi clear Include           " hi Include           term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear Define            " hi Define            term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear Macro             " hi Macro             term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear PreCondit         " hi PreCondit         term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi Type                                                           cterm=bold                                                      guifg=#0087ff
hi clear StorageClass      " hi StorageClass      term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear Structure         " hi Structure         term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear Typedef           " hi Typedef           term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none

" Diff
hi clear DiffAdd           " hi DiffAdd           term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear DiffChange        " hi DiffChange        term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear DiffDelete        " hi DiffDelete        term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear DiffText          " hi DiffText          term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none

" Completion menu
hi Pmenu guifg=#ffffff    guibg=NONE
hi PmenuSel  cterm=bold guifg=#00ffff    guibg=#0000ff
hi PmenuSbar guifg=#00ffff    guibg=#0000ff
hi PmenuThumb guifg=#00ffff    guibg=#0000ff

" Spelling
hi clear SpellBad          " hi SpellBad          term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear SpellCap          " hi SpellCap          term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear SpellLocal        " hi SpellLocal        term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear SpellRare         " hi SpellRare         term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none

" Tool bar
hi clear ToolbarLine       " hi ToolbarLine       term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none
hi clear ToolbarButton     " hi ToolbarButton     term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none

" Etc
hi clear Conceal           " hi Conceal           term=none       cterm=none      ctermfg=none  ctermbg=none     gui=none         guifg=none       guibg=none       guisp=none


" syntax/diff
hi DiffRemoved guifg=#ff0000
hi DiffAdded guifg=#5fdf00
hi diffFile cterm=bold guifg=#759fad
hi diffIndexLine guifg=#00ffff    guibg=#0000ff
