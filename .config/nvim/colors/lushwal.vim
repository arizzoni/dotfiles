set background=dark
if exists('g:colors_name')
hi clear
if exists('syntax_on')
syntax reset
endif
endif
let g:colors_name = 'lushwal'
highlight Normal guifg=#C7C7C7 guibg=#000000 guisp=NONE blend=NONE gui=NONE
highlight! link User Normal
highlight Bold guifg=#C7C7C7 guibg=#000000 guisp=NONE blend=NONE gui=bold
highlight Boolean guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=italic
highlight Character guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=italic
highlight CmpItemAbbr guifg=#DFEBDB guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CmpItemAbbrDeprecated guifg=#DFEBDB guibg=NONE guisp=NONE blend=NONE gui=strikethrough
highlight CmpItemAbbrMatch guifg=#DFEBDB guibg=NONE guisp=NONE blend=NONE gui=bold
highlight CmpItemAbbrMatchFuzzy guifg=#DFEBDB guibg=NONE guisp=NONE blend=NONE gui=bold
highlight CmpItemKind guifg=#327C86 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CmpItemMenu guifg=#5C6959 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight ColorColumn guifg=#5C6959 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Comment guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=italic
highlight Conceal guifg=#90A28B guibg=#000000 guisp=NONE blend=NONE gui=NONE
highlight! link Whitespace Conceal
highlight Conditional guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight Constant guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Cursor guifg=#000000 guibg=#C7C7C7 guisp=NONE blend=NONE gui=NONE
highlight CursorColumn guifg=#5C6959 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CursorLine guifg=#90A28B guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CursorLineNr guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight Debug guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Define guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight Delimiter guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiagnosticError guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiagnosticHint guifg=#327C86 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiagnosticInfo guifg=#63773C guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiagnosticUnderlineError guifg=#6BAD58 guibg=NONE guisp=#6BAD58 blend=NONE gui=underline
highlight DiagnosticUnderlineHint guifg=#327C86 guibg=NONE guisp=#327C86 blend=NONE gui=underline
highlight DiagnosticUnderlineInfo guifg=#63773C guibg=NONE guisp=#63773C blend=NONE gui=underline
highlight DiagnosticUnderlineWarn guifg=#524884 guibg=NONE guisp=#524884 blend=NONE gui=underline
highlight DiagnosticWarn guifg=#524884 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffAdd guifg=#9D7953 guibg=#90A28B guisp=NONE blend=NONE gui=bold
highlight! link DiffAdded DiffAdd
highlight DiffChange guifg=#DFEBDB guibg=#90A28B guisp=NONE blend=NONE gui=NONE
highlight DiffDelete guifg=#6BAD58 guibg=#90A28B guisp=NONE blend=NONE gui=bold
highlight! link DiffRemoved DiffDelete
highlight! link diffRemoved DiffDelete
highlight DiffFile guifg=#6BAD58 guibg=#000000 guisp=NONE blend=NONE gui=NONE
highlight DiffLine guifg=#63773C guibg=#000000 guisp=NONE blend=NONE gui=NONE
highlight DiffNewFile guifg=#9D7953 guibg=#000000 guisp=NONE blend=NONE gui=NONE
highlight DiffText guifg=#63773C guibg=#90A28B guisp=NONE blend=NONE gui=NONE
highlight Directory guifg=#63773C guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight EndOfBuffer guifg=#C7C7C7 guibg=#000000 guisp=NONE blend=NONE gui=NONE
highlight Error guifg=#6BAD58 guibg=#DFEBDB guisp=NONE blend=NONE gui=NONE
highlight ErrorMsg guifg=#6BAD58 guibg=#000000 guisp=NONE blend=NONE gui=NONE
highlight Exception guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight FloatBorder guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link TelescopeBorder FloatBorder
highlight! link WhichKeyBorder FloatBorder
highlight FoldColumn guifg=#63773C guibg=#000000 guisp=NONE blend=NONE gui=NONE
highlight Folded guifg=#5C6959 guibg=#90A28B guisp=NONE blend=NONE gui=italic
highlight Function guifg=#63773C guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight GitSignsAdd guifg=#327C86 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight GitSignsChange guifg=#524884 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight GitSignsDelete guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Identifier guifg=#327C86 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight IncSearch guifg=#90A28B guibg=#6BAD58 guisp=NONE blend=NONE gui=NONE
highlight Include guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight IndentBlanklineChar guifg=#90A28B guibg=NONE guisp=NONE blend=NONE gui=nocombine
highlight IndentBlanklineContextChar guifg=#5C6959 guibg=NONE guisp=NONE blend=NONE gui=nocombine
highlight IndentBlanklineContextStart guifg=NONE guibg=NONE guisp=#5C6959 blend=NONE gui=underline
highlight Italic guifg=#C7C7C7 guibg=#000000 guisp=NONE blend=NONE gui=italic
highlight Keyword guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight Label guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight LazyButton guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight LazyButtonActive guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight LazyComment guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=italic
highlight LazyCommitIssue guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=italic
highlight LazyCommitScope guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=italic
highlight LazyH1 guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight LazyH2 guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight LazyReasonEvent guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=italic
highlight LazyReasonImport guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=italic
highlight LazyReasonPlugin guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=italic
highlight LazyReasonRequire guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=italic
highlight LazyReasonSource guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight LazyReasonStart guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight LineNr guifg=#DFEBDB guibg=#000000 guisp=NONE blend=NONE gui=NONE
highlight Macro guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MasonError guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight MasonHeader guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight MasonHeaderSecondary guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight MasonHeading guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight MasonHighlightBlockBold guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight MasonHighlightBlockBoldSecondary guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight MasonMutedBlockBold guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight MasonWarning guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight MatchParen guifg=#C7C7C7 guibg=#DFEBDB guisp=NONE blend=NONE gui=NONE
highlight MiniCompletionActiveParameter guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MiniCursorword guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=underline
highlight! link MiniCursorwordCurrent MiniCursorword
highlight MiniIndentscopePrefix guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=nocombine
highlight MiniIndentscopeSymbol guifg=#90A28B guibg=#000000 guisp=NONE blend=NONE gui=NONE
highlight MiniJump guifg=#63773C guibg=NONE guisp=#DFEBDB blend=NONE gui=underline
highlight MiniJump2dSpot guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=undercurl
highlight MiniStarterCurrent guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MiniStarterFooter guifg=#63773C guibg=NONE guisp=NONE blend=NONE gui=bold
highlight MiniStarterHeader guifg=#63773C guibg=NONE guisp=NONE blend=NONE gui=bold
highlight MiniStarterInactive guifg=#5C6959 guibg=NONE guisp=NONE blend=NONE gui=italic
highlight MiniStarterItem guifg=#C7C7C7 guibg=#000000 guisp=NONE blend=NONE gui=NONE
highlight MiniStarterItemBullet guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MiniStarterItemPrefix guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MiniStarterQuery guifg=#9D7953 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MiniStarterSection guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MiniStatuslineDevinfo guifg=#5C6959 guibg=#90A28B guisp=NONE blend=NONE gui=NONE
highlight MiniStatuslineFileinfo guifg=#5C6959 guibg=#90A28B guisp=NONE blend=NONE gui=NONE
highlight MiniStatuslineFilename guifg=#524884 guibg=#90A28B guisp=NONE blend=NONE gui=NONE
highlight MiniStatuslineInactive guifg=#5C6959 guibg=#90A28B guisp=NONE blend=NONE gui=NONE
highlight MiniStatuslineModeCommand guifg=#000000 guibg=#327C86 guisp=NONE blend=NONE gui=NONE
highlight MiniStatuslineModeInsert guifg=#000000 guibg=#63773C guisp=NONE blend=NONE gui=NONE
highlight MiniStatuslineModeNormal guifg=#000000 guibg=#9D7953 guisp=NONE blend=NONE gui=NONE
highlight MiniStatuslineModeOther guifg=#000000 guibg=#63773C guisp=NONE blend=NONE gui=NONE
highlight MiniStatuslineModeReplace guifg=#000000 guibg=#6BAD58 guisp=NONE blend=NONE gui=NONE
highlight MiniStatuslineModeVisual guifg=#000000 guibg=#6BAD58 guisp=NONE blend=NONE gui=NONE
highlight MiniSurround guifg=#90A28B guibg=#6BAD58 guisp=NONE blend=NONE gui=NONE
highlight MiniTablineCurrent guifg=#DFEBDB guibg=#90A28B guisp=NONE blend=NONE gui=NONE
highlight MiniTablineFill guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MiniTablineHidden guifg=#9D7953 guibg=#90A28B guisp=NONE blend=NONE gui=NONE
highlight MiniTablineModifiedCurrent guifg=#5C6959 guibg=#90A28B guisp=NONE blend=NONE gui=NONE
highlight MiniTablineModifiedHidden guifg=#5C6959 guibg=#90A28B guisp=NONE blend=NONE gui=NONE
highlight MiniTablineModifiedVisible guifg=#5C6959 guibg=#90A28B guisp=NONE blend=NONE gui=NONE
highlight MiniTablineVisible guifg=#DFEBDB guibg=#90A28B guisp=NONE blend=NONE gui=NONE
highlight MiniTestEmphasis guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight MiniTestFail guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight MiniTestPass guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight MiniTrailspace guifg=#6BAD58 guibg=#DFEBDB guisp=NONE blend=NONE gui=NONE
highlight ModeMsg guifg=#9D7953 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MoreMsg guifg=#9D7953 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight NonText guifg=#DFEBDB guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Number guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link Float Number
highlight Operator guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight PMenu guifg=#5C6959 guibg=#90A28B guisp=NONE blend=NONE gui=NONE
highlight PMenuSel guifg=#C7C7C7 guibg=#63773C guisp=NONE blend=NONE gui=NONE
highlight PmenuSbar guifg=#5C6959 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight PmenuThumb guifg=#C7C7C7 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight PreProc guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight Question guifg=#63773C guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Repeat guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight Search guifg=#DFEBDB guibg=#524884 guisp=NONE blend=NONE gui=NONE
highlight! link MiniTablineTabpagesection Search
highlight SignColumn guifg=#5C6959 guibg=#000000 guisp=NONE blend=NONE gui=NONE
highlight Special guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight SpecialChar guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight SpecialComment guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight SpecialKey guifg=#DFEBDB guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight SpellBad guifg=#6BAD58 guibg=NONE guisp=#6BAD58 blend=NONE gui=underline
highlight SpellCap guifg=#524884 guibg=NONE guisp=#524884 blend=NONE gui=underline
highlight SpellLocal guifg=#327C86 guibg=NONE guisp=#327C86 blend=NONE gui=underline
highlight SpellRare guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=underline
highlight Statement guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight StatusLine guifg=#5C6959 guibg=#90A28B guisp=NONE blend=NONE gui=NONE
highlight StatusLineNC guifg=#5C6959 guibg=#90A28B guisp=NONE blend=NONE gui=NONE
highlight StatusLineTerm guifg=#D3A26F guibg=#9D7953 guisp=NONE blend=NONE gui=NONE
highlight StatusLineTermNC guifg=#6C61AE guibg=#90A28B guisp=NONE blend=NONE gui=NONE
highlight StorageClass guifg=#524884 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight String guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=italic
highlight Structure guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=italic
highlight TabLine guifg=#DFEBDB guibg=#90A28B guisp=NONE blend=NONE gui=NONE
highlight TabLineFill guifg=#DFEBDB guibg=#90A28B guisp=NONE blend=NONE gui=NONE
highlight TabLineSel guifg=#9D7953 guibg=#90A28B guisp=NONE blend=NONE gui=NONE
highlight Tag guifg=#524884 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeMatching guifg=#6C61AE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeMultiSelection guifg=#524884 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight TelescopePromptBorder guifg=#DFEBDB guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopePromptCounter guifg=#63773C guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeSelection guifg=#2A8B98 guibg=#90A28B guisp=NONE blend=NONE gui=NONE
highlight TelescopeSelectionCaret guifg=#2A8B98 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Title guifg=#63773C guibg=NONE guisp=NONE blend=NONE gui=bold
highlight Todo guifg=#524884 guibg=#90A28B guisp=NONE blend=NONE gui=NONE
highlight TooLong guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Type guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=italic
highlight Typedef guifg=#524884 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Underlined guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight VertSplit guifg=#5C6959 guibg=#000000 guisp=NONE blend=NONE gui=NONE
highlight! link WinSeparator VertSplit
highlight Visual guifg=#000000 guibg=#5C6959 guisp=NONE blend=NONE gui=NONE
highlight VisualNOS guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight WarningMsg guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight WhichKey guifg=#C7AE94 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight WhichKeyDesc guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight WhichKeyFloat guifg=NONE guibg=#919191 guisp=NONE blend=NONE gui=NONE
highlight WhichKeyGroup guifg=#327C86 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight WhichKeySeparator guifg=#DFEBDB guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight WhichKeySeperator guifg=#DFEBDB guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight WhichKeyValue guifg=#DFEBDB guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight WildMenu guifg=#C7C7C7 guibg=#63773C guisp=NONE blend=NONE gui=NONE
highlight WinBar guifg=#5C6959 guibg=#000000 guisp=NONE blend=NONE gui=NONE
highlight WinBarNC guifg=#5C6959 guibg=#000000 guisp=NONE blend=NONE gui=NONE
highlight gitCommitOverflow guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight gitCommitSummary guifg=#9D7953 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight helpCommand guifg=#524884 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight helpExample guifg=#524884 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight mkdBold guifg=#524884 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link markdownBold mkdBold
highlight mkdCode guifg=#9D7953 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link markdownCode mkdCode
highlight mkdCodeBlock guifg=#9D7953 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link markdownCodeBlock mkdCodeBlock
highlight mkdCodeDelimiter guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=italic
highlight! link markdownCodeDelimiter mkdCodeDelimiter
highlight mkdError guifg=#C7C7C7 guibg=#000000 guisp=NONE blend=NONE gui=NONE
highlight! link markdownError mkdError
highlight mkdH1 guifg=#63773C guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link markdownH1 mkdH1
highlight mkdH2 guifg=#63773C guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link markdownH2 mkdH2
highlight mkdHeadingDelimiter guifg=#63773C guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link markdownHeadingDelimiter mkdHeadingDelimiter
highlight mkdItalic guifg=#63773C guibg=NONE guisp=NONE blend=NONE gui=italic
highlight! link markdownItalic mkdItalic
highlight @attribute guifg=#63773C guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @boolean guifg=#63773C guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @character guifg=#524884 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @character.special guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @comment guifg=#5C6959 guibg=NONE guisp=NONE blend=NONE gui=italic
highlight @conditional guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @constant guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @constant.builtin guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @constant.macro guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @constructor guifg=#C7C7C7 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @debug guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @define guifg=#63773C guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @exception guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @field guifg=#9D7953 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @float guifg=#63773C guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @function guifg=#63773C guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @function.builtin guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @function.macro guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @include guifg=#327C86 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @keyword guifg=#63773C guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @keyword.function guifg=#327C86 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @keyword.operator guifg=#63773C guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @label guifg=#327C86 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @method guifg=#63773C guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @namespace guifg=#63773C guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @none guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @number guifg=#63773C guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @operator guifg=#C7C7C7 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @parameter guifg=#524884 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @preproc guifg=#524884 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @property guifg=#524884 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @punctuation.bracket guifg=#C7C7C7 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @punctuation.delimiter guifg=#C7C7C7 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @punctuation.special guifg=#2A8B98 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @repeat guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @storageclass guifg=#524884 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @string guifg=#63773C guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @string.escape guifg=#9D7953 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @string.regex guifg=#9D7953 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @string.special guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @symbol guifg=#327C86 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @tag guifg=#524884 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @tag.attribute guifg=#327C86 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @tag.delimiter guifg=#327C86 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @text guifg=#9D7953 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @text.bold guifg=#524884 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @text.danger guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @text.diff.add guifg=#9D7953 guibg=#90A28B guisp=NONE blend=NONE gui=bold
highlight @text.diff.delete guifg=#6BAD58 guibg=#90A28B guisp=NONE blend=NONE gui=bold
highlight @text.emphasis guifg=#63773C guibg=NONE guisp=NONE blend=NONE gui=italic
highlight @text.environment guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @text.environment.name guifg=#524884 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @text.literal guifg=#9D7953 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @text.math guifg=#327C86 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @text.note guifg=#327C86 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @text.reference guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @text.strike guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=strikethrough
highlight @text.title guifg=#63773C guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @text.todo guifg=#524884 guibg=#90A28B guisp=NONE blend=NONE gui=NONE
highlight @text.underline guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=underline
highlight @text.uri guifg=NONE guibg=#90A28B guisp=NONE blend=NONE gui=underline
highlight @type guifg=#63773C guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @type.builtin guifg=#63773C guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @type.definition guifg=#524884 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @variable guifg=#524884 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @variable.builtin guifg=#6BAD58 guibg=NONE guisp=NONE blend=NONE gui=NONE
