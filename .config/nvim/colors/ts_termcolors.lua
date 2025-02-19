vim.o.termguicolors = false
vim.g.colors_name = "ts_termcolors"

local function set_hl(group, options)
	vim.api.nvim_set_hl(0, group, options)
end

set_hl("Comment", { italic = true, ctermfg = 8 })
set_hl("ColorColumn", { ctermbg = 8 })
set_hl("Conceal", { ctermfg = 0 })
set_hl("Cursor", { ctermfg = 15 })
set_hl("lCursor", { ctermfg = 15 })
set_hl("CursorIM", { ctermfg = 15 })
set_hl("CursorColumn", { ctermbg = 8 })
set_hl("CursorLine", { ctermbg = 8 })
set_hl("Directory", { ctermfg = 1 })
set_hl("Directory", { ctermfg = 1 })
set_hl("DiffAdd", { ctermfg = 1 })
set_hl("DiffChange", { ctermfg = 2 })
set_hl("DiffDelete", { ctermfg = 3 })
set_hl("DiffText", { link = "Normal", ctermbg = 8 })
set_hl("EndOfBuffer", { link = "Normal", ctermbg = 8 })
set_hl("ErrorMsg", { ctermfg = 15 })
set_hl("VertSplit", { ctermfg = 8, ctermbg = 0 })
set_hl("WinSeparator", { ctermfg = 8, ctermbg = 0 })
set_hl("Folded", { ctermfg = 8, ctermbg = 0 })
set_hl("FoldColumn", { ctermfg = 8, ctermbg = 0 })
set_hl("SignColumn", { ctermfg = 8 })
set_hl("SignColumnSB", { ctermfg = 8 })
set_hl("Substitute", { ctermfg = 9, ctermbg = 1 })
set_hl("LineNr", { ctermfg = 15 })
set_hl("CursorLineNr", { bold = true, ctermfg = 15, ctermbg = 0 })
set_hl("LineNrAbove", { ctermfg = 8 })
set_hl("LineNrBelow", { ctermfg = 8 })
set_hl("MatchParen", { bold = true, ctermfg = 0, ctermbg = 15 })
set_hl("ModeMsg", { ctermfg = 15 })
set_hl("MsgArea", { ctermfg = 15 })
set_hl("MoreMsg", { ctermfg = 15 })
set_hl("NonText", { ctermfg = 8 })
set_hl("Normal", { ctermfg = 15 })
set_hl("NormalNC", { ctermfg = 15 })
set_hl("NormalSB", { ctermfg = 15 })
set_hl("NormalFloat", { ctermfg = 15 })
set_hl("Float", { ctermfg = 15 })
set_hl("FloatBorder", { bold = true, ctermfg = 15, ctermbg = 8 })
set_hl("FloatTitle", { bold = true, ctermfg = 15, ctermbg = 8 })
set_hl("Pmenu", { ctermfg = 15, ctermbg = 0 })
set_hl("PmenuMatch", { ctermfg = 15, ctermbg = 8 })
set_hl("PmenuSel", { bold = true, ctermfg = 15, ctermbg = 0 })
set_hl("PmenuMatchSel", { bold = true, ctermfg = 15, ctermbg = 8 })
set_hl("PmenuSbar", { ctermfg = 15, ctermbg = 0 })
set_hl("PmenuThumb", { ctermfg = 15, ctermbg = 0 })
set_hl("Question", { ctermfg = 9, ctermbg = 0 })
set_hl("QuickFixLine", { ctermfg = 10, ctermbg = 0 })
set_hl("Search", { ctermfg = 15, ctermbg = 11 })
set_hl("IncSearch", { ctermfg = 15, ctermbg = 11 })
set_hl("CurSearch", { ctermfg = 15, ctermbg = 11 })
set_hl("SpecialKey", { ctermfg = 0 })
set_hl("SpellBad", { underline = true, ctermfg = 1 })
set_hl("SpellCap", { underline = true, ctermfg = 2 })
set_hl("SpellLocal", { underline = true, ctermfg = 3 })
set_hl("SpellRare", { underline = true, ctermfg = 4 })
set_hl("StatusLine", { ctermfg = 15 })
set_hl("StatusLineNC", { ctermfg = 8, ctermbg = 0 })
set_hl("StatusLineNormal", { bold = true, ctermfg = 15, ctermbg = 1 })
set_hl("StatusLineInsert", { bold = true, ctermfg = 15, ctermbg = 2 })
set_hl("StatusLineVisual", { bold = true, ctermfg = 15, ctermbg = 3 })
set_hl("StatusLineCommand", { bold = true, ctermfg = 15, ctermbg = 4 })
set_hl("StatusLineReplace", { bold = true, ctermfg = 15, ctermbg = 5 })
set_hl("StatusLineSelect", { bold = true, ctermfg = 15, ctermbg = 6 })
set_hl("StatusLineTerminal", { bold = true, ctermfg = 15, ctermbg = 8 })
set_hl("StatusLineDiagnostics", { ctermfg = 15, ctermbg = 0 })
set_hl("StatusLineFilepath", { ctermfg = 12 })
set_hl("StatusLineLSP", { ctermfg = 8 })
set_hl("StatusLineFileInfo", { ctermfg = 8 })
set_hl("StatusLineModified", { ctermfg = 8 })
set_hl("StatusLineVersionControl", { ctermfg = 5 })
set_hl("StatusLineCursorPos", { ctermfg = 15, ctermbg = 1 })
set_hl("TabLineCurrentTab", { ctermfg = 15, ctermbg = 1 })
set_hl("TabLineTabs", { ctermfg = 15, ctermbg = 2 })
set_hl("TabLineCurrentBuf", { ctermfg = 15, ctermbg = 3 })
set_hl("TabLineBufs", { ctermfg = 15, ctermbg = 4 })
set_hl("TabLine", { ctermfg = 15 })
set_hl("TabLineFill", { ctermfg = 15 })
set_hl("TabLineSel", { ctermfg = 15, ctermbg = 0 })
set_hl("Title", { bold = true, ctermfg = 15, ctermbg = 0 })
set_hl("Visual", { ctermfg = 0, ctermbg = 15 })
set_hl("VisualNOS", { ctermfg = 0, ctermbg = 8 })
set_hl("WarningMsg", { ctermfg = 15, ctermbg = 12 })
set_hl("Whitespace", { ctermfg = 15 })
set_hl("WildMenu", { ctermfg = 15 })
set_hl("WinBar", { ctermfg = 15, ctermbg = 0 })
set_hl("WinBarNC", { ctermfg = 15, ctermbg = 8 })

set_hl("Array", { link = "Float" })
set_hl("Class", { link = "Structure" })
set_hl("Color", { link = "Special" })
set_hl("Constructor", { link = "Function" })
set_hl("Enum", { link = "Constant" })
set_hl("EnumMember", { link = "Constant" })
set_hl("Event", { link = "Special" })
set_hl("Field", { link = "Variable" })
set_hl("File", { link = "Normal" })
set_hl("Folder", { link = "Directory" })
set_hl("Interface", { link = "Function" })
set_hl("Key", { link = "Variable" })
set_hl("Method", { link = "Function" })
set_hl("Module", { link = "Include" })
set_hl("Namespace", { link = "Include" })
set_hl("Null", { link = "Constant" })
set_hl("Number", { link = "Normal", ctermfg = 2 })
set_hl("Object", { link = "Constant" })
set_hl("Package", { link = "Include" })
set_hl("Reference", { link = "Special" })
set_hl("Snippet", { link = "Conceal" })
set_hl("Struct", { link = "Structure" })
set_hl("Unit", { link = "Structure" })
set_hl("Text", { link = "Normal" })
set_hl("TypeParameter", { link = "Type" })
set_hl("Variable", { ctermfg = 4 })
set_hl("Value", { link = "String", italic = false })

set_hl("Boolean", { bold = true, ctermfg = 3 })
set_hl("Bold", { link = "Normal", bold = true })
set_hl("Character", { italic = true, ctermfg = 12 })
set_hl("Constant", { ctermfg = 5 })
set_hl("Constructor", { ctermfg = 2 })
set_hl("Debug", { bold = true, ctermfg = 5 })
set_hl("Delimiter", { ctermfg = 15 })
set_hl("Define", { bold = true, ctermfg = 3 })
set_hl("Error", { ctermfg = 9 })
set_hl("Exception", { ctermfg = 9 })
set_hl("Function", { bold = true, ctermfg = 2 })
set_hl("Identifier", { ctermfg = 14 })
set_hl("Italic", { link = "Normal", italic = true })
set_hl("Include", { bold = true, ctermfg = 10 })
set_hl("Keyword", { bold = true, ctermfg = 2 })
set_hl("Label", { ctermfg = 12 })
set_hl("Macro", { ctermfg = 2 })
set_hl("Operator", { bold = true })
set_hl("PreProc", { ctermfg = 1 })
set_hl("Property", { ctermfg = 13 })
set_hl("Repeat", { bold = true, ctermfg = 10 })
set_hl("SpecialChar", { bold = true, ctermfg = 12 })
set_hl("Special", { ctermfg = 6 })
set_hl("Statement", { ctermfg = 2 })
set_hl("StorageClass", { ctermfg = 3 })
set_hl("String", { italic = true, ctermfg = 4 })
set_hl("Structure", { bold = true, ctermfg = 3 })
set_hl("Todo", { bold = true, ctermfg = 0, ctermbg = 15 })
set_hl("Type", { ctermfg = 13 })
set_hl("Typedef", { ctermfg = 13 })
set_hl("Underlined", { link = "Normal", underline = true })

set_hl("DiagnosticError", { link = "Error" })
set_hl("DiagnosticWarn", { link = "WarningMsg" })
set_hl("DiagnosticInfo", { link = "Normal" })
set_hl("DiagnosticHint", { link = "Normal" })
set_hl("DiagnosticUnnecessary", { link = "WarningMsg" })
set_hl("DiagnosticVirtualTextError", { link = "DiagnosticError" })
set_hl("DiagnosticVirtualTextWarn", { link = "DiagnosticWarningMsg" })
set_hl("DiagnosticVirtualTextInfo", { link = "DiagnosticInfo" })
set_hl("DiagnosticVirtualTextHint", { link = "DiagnosticHint" })
set_hl("DiagnosticUnderlineError", { link = "DiagnosticError" })
set_hl("DiagnosticUnderlineWarn", { link = "DiagnosticWarningMsg" })
set_hl("DiagnosticUnderlineInfo", { link = "DiagnosticHint" })
set_hl("DiagnosticUnderlineHint", { link = "DiagnosticHint" })

set_hl("healthError", { link = "Error" })
set_hl("healthSuccess", { link = "Normal" })
set_hl("healthWarning", { link = "WarningMsg" })

set_hl("diffAdded", { link = "DiffAdd" })
set_hl("diffRemoved", { link = "DiffDelete" })
set_hl("diffChanged", { link = "DiffChange" })
set_hl("diffOldFile", { link = "DiffChange", italic = true })
set_hl("diffNewFile", { link = "DiffChange", bold = true })
set_hl("diffFile", { link = "Comment" })
set_hl("diffLine", { link = "Comment" })
set_hl("diffIndexLine", { link = "DiffChange", ctermfg = 4 })
set_hl("helpExample", { link = "Comment" })

set_hl("CmpDocumentation", { link = "Float" })
set_hl("CmpDocumentation", { link = "FloatBorder" })
set_hl("CmpGhostText", { link = "Conceal" })
set_hl("CmpItemAbbr", { link = "Float" })
set_hl("CmpItemAbbrDeprecated", { link = "Float", strikethrough = true })
set_hl("CmpItemAbbrMatch", { link = "Float", bold = true })
set_hl("CmpItemAbbrMatchFuzzy", { link = "Float", bold = true })
set_hl("CmpItemKindDefault", { link = "Float" })
set_hl("CmpItemMenu", { link = "Float" })

set_hl("DapStoppedLine", { link = "WarningMsg" })

set_hl("GitSignsAdd", { link = "DiffAdd" })
set_hl("GitSignsChange", { link = "DiffChange" })
set_hl("GitSignsDelete", { link = "DiffDelete" })

set_hl("IndentBlankLineChar", { ctermfg = 0 })
set_hl("IndentBlankLineContextChar", { ctermfg = 8 })
set_hl("IblIndent", { link = "IndentBlankLineChar", nocombine = true })
set_hl("IblScope", { link = "IndentBlankLineContextChar", nocombine = true })

set_hl("LazyProgressDone", { link = "Float", bold = true })
set_hl("LazyProgressTodo", { link = "Float", bold = true })

set_hl("TreesitterContext", { link = "Comment" })
set_hl("TreesitterContextBottom", { link = "Comment" })
set_hl("TreesitterContextSeparator", { link = "Comment" })
set_hl("TreesitterContextLineNumber", { link = "Comment" })
set_hl("TreesitterContextLineNumberBottom", { link = "Comment" })

set_hl("WhichKey", { link = "Float" })
set_hl("WhichKeyGroup", { link = "Float" })
set_hl("WhichKeyDesc", { link = "Float" })
set_hl("WhichKeySeparator", { link = "Float" })
set_hl("WhichKeyNormal", { link = "Float" })
set_hl("WhichKeyValue", { link = "Float" })

set_hl("@annotation", { link = "PreProc" })
set_hl("@attribute", { link = "PreProc" })
set_hl("@boolean", { link = "Boolean" })
set_hl("@character", { link = "Character" })
set_hl("@character.printf", { link = "SpecialChar" })
set_hl("@character.special", { link = "SpecialChar" })
set_hl("@comment", { link = "Comment" })
set_hl("@constant", { link = "Constant" })
set_hl("@constant.builtin", { link = "Special" })
set_hl("@constant.macro", { link = "Define" })
set_hl("@constructor", { link = "Constructor" })
set_hl("@diff.delta", { link = "DiffChange" })
set_hl("@diff.minus", { link = "DiffDelete" })
set_hl("@diff.plus", { link = "DiffAdd" })
set_hl("@exception", { link = "Exception" })
set_hl("@field", { link = "String" })
set_hl("@function", { link = "Function" })
set_hl("@function.builtin", { link = "Special" })
set_hl("@function.call", { link = "Function" })
set_hl("@function.macro", { link = "Macro" })
set_hl("@function.method", { link = "Function" })
set_hl("@function.method.call", { link = "Function" })
set_hl("@keyword", { link = "Keyword" })
set_hl("@keyword.conditional", { link = "Conditional" })
set_hl("@keyword.coroutine", { link = "Keyword" })
set_hl("@keyword.debug", { link = "Debug" })
set_hl("@keyword.directive", { link = "PreProc" })
set_hl("@keyword.directive.define", { link = "Define" })
set_hl("@keyword.exception", { link = "Exception" })
set_hl("@keyword.function", { link = "Function" })
set_hl("@keyword.import", { link = "Include" })
set_hl("@keyword.operator", { link = "Operator" })
set_hl("@keyword.repeat", { link = "Repeat" })
set_hl("@keyword.return", { link = "Keyword" })
set_hl("@keyword.storage", { link = "StorageClass" })
set_hl("@label", { link = "Label" })
set_hl("@markup", { link = "Normal" })
set_hl("@markup.emphasis", { link = "Normal" })
set_hl("@markup.environment", { link = "Macro" })
set_hl("@markup.environment.name", { link = "Type" })
set_hl("@markup.heading", { link = "Title" })
set_hl("@markup.italic", { link = "Normal" })
set_hl("@markup.link", { link = "Special" })
set_hl("@markup.link.label", { link = "SpecialChar" })
set_hl("@markup.link.label.symbol", { link = "Identifier" })
set_hl("@markup.link.url", { link = "Underlined" })
set_hl("@markup.list", { link = "Function" })
set_hl("@markup.list.checked", { link = "Function" })
set_hl("@markup.list.markdown", { link = "PreProc" })
set_hl("@markup.list.unchecked", { link = "Macro" })
set_hl("@markup.math", { link = "Special" })
set_hl("@markup.raw", { link = "String" })
set_hl("@markup.raw.markdown_inline", { link = "String" })
set_hl("@markup.strikethrough", { link = "Normal" })
set_hl("@markup.strong", { link = "Normal" })
set_hl("@markup.underline", { link = "Normal" })
set_hl("@method", { link = "Function" })
set_hl("@module", { link = "Include" })
set_hl("@module.builtin", { link = "Include" })
set_hl("@namespace", { link = "Structure" })
set_hl("@namespace.builtin", { link = "Structure" })
set_hl("@none", {})
set_hl("@number", { link = "Number" })
set_hl("@number.float", { link = "Float" })
set_hl("@operator", { link = "Operator" })
set_hl("@preproc", { link = "PreProc" })
set_hl("@property", { link = "Property" })
set_hl("@punctuation.bracket", { link = "Normal" })
set_hl("@punctuation.delimiter", { link = "Normal" })
set_hl("@punctuation.special", { link = "Normal" })
set_hl("@punctuation.special.markdown", { link = "Normal" })
set_hl("@string", { link = "String" })
set_hl("@string.documentation", { link = "Normal" })
set_hl("@string.escape", { link = "String" })
set_hl("@string.regexp", { link = "String" })
set_hl("@symbol", { link = "Character" })
set_hl("@tag", { link = "Label" })
set_hl("@tag.attribute", { link = "Property" })
set_hl("@tag.delimiter", { link = "Property" })
set_hl("@text", { link = "Normal" })
set_hl("@text.bold", { link = "Bold" })
set_hl("@text.danger", { link = "Error" })
set_hl("@text.diff.add", { link = "DiffAdd" })
set_hl("@text.diff.delete", { link = "DiffDelete" })
set_hl("@text.emphasis", { link = "Italic" })
set_hl("@text.environment", { link = "Bold" })
set_hl("@text.environment.name", { link = "Bold" })
set_hl("@text.literal", { link = "Character" })
set_hl("@text.math", { link = "Float" })
set_hl("@text.note", { link = "Label" })
set_hl("@text.reference", { link = "Tag" })
set_hl("@text.strike", { link = "Normal" })
set_hl("@text.strong", { link = "Bold" })
set_hl("@text.title", { link = "Title" })
set_hl("@text.todo", { link = "Exception" })
set_hl("@text.underline", { link = "Underlined" })
set_hl("@text.uri", { link = "Underlined" })
set_hl("@type", { link = "Type" })
set_hl("@type.builtin", { link = "Type" })
set_hl("@type.definition", { link = "Typedef" })
set_hl("@type.qualifier", { link = "Keyword" })
set_hl("@variable", { link = "Variable" })
set_hl("@variable.builtin", { link = "Variable" })
set_hl("@variable.member", { link = "Variable" })
set_hl("@variable.parameter", { link = "Variable" })
set_hl("@variable.parameter.builtin", { link = "Variable" })

local lsp_group = vim.api.nvim_create_augroup("LspGroup", { clear = false })
vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_group,
	pattern = "*",
	callback = function()
		set_hl("@lsp.type.boolean", { link = "@boolean" })
		set_hl("@lsp.type.builtinType", { link = "@type.builtin" })
		set_hl("@lsp.type.comment", { link = "@comment" })
		set_hl("@lsp.type.decorator", { link = "@attribute" })
		set_hl("@lsp.type.deriveHelper", { link = "@attribute" })
		set_hl("@lsp.type.enum", { link = "@type" })
		set_hl("@lsp.type.enumMember", { link = "@constant" })
		set_hl("@lsp.type.escapeSequence", { link = "@string.escape" })
		set_hl("@lsp.type.formatSpecifier", { link = "@markup.list" })
		set_hl("@lsp.type.generic", { link = "@variable" })
		set_hl("@lsp.type.interface", { link = "@attribute" })
		set_hl("@lsp.type.keyword", { link = "@keyword" })
		set_hl("@lsp.type.lifetime", { link = "@keyword.storage" })
		set_hl("@lsp.type.namespace", { link = "@module" })
		set_hl("@lsp.type.namespace.python", { link = "@variable" })
		set_hl("@lsp.type.number", { link = "@number" })
		set_hl("@lsp.type.operator", { link = "@operator" })
		set_hl("@lsp.type.parameter", { link = "@variable.parameter" })
		set_hl("@lsp.type.property", { link = "@property" })
		set_hl("@lsp.type.selfKeyword", { link = "@variable.builtin" })
		set_hl("@lsp.type.selfTypeKeyword", { link = "@variable.builtin" })
		set_hl("@lsp.type.string", { link = "@string" })
		set_hl("@lsp.type.typeAlias", { link = "@type.definition" })
		set_hl("@lsp.type.unresolvedReference", { link = "@annotation" })
		set_hl("@lsp.type.variable", { link = "@variable" })
		set_hl("@lsp.typemod.class.defaultLibrary", { link = "@type.builtin" })
		set_hl("@lsp.typemod.enum.defaultLibrary", { link = "@type.builtin" })
		set_hl("@lsp.typemod.enumMember.defaultLibrary", { link = "@constant.builtin" })
		set_hl("@lsp.typemod.function.defaultLibrary", { link = "@function.builtin" })
		set_hl("@lsp.typemod.keyword.async", { link = "@keyword.coroutine" })
		set_hl("@lsp.typemod.keyword.injected", { link = "@keyword" })
		set_hl("@lsp.typemod.macro.defaultLibrary", { link = "@function.builtin" })
		set_hl("@lsp.typemod.method.defaultLibrary", { link = "@function.builtin" })
		set_hl("@lsp.typemod.operator.injected", { link = "@operator" })
		set_hl("@lsp.typemod.string.injected", { link = "@string" })
		set_hl("@lsp.typemod.struct.defaultLibrary", { link = "@type.builtin" })
		set_hl("@lsp.typemod.type.defaultLibrary", { link = "@type.builtin" })
		set_hl("@lsp.typemod.typeAlias.defaultLibrary", { link = "@type.builtin" })
		set_hl("@lsp.typemod.variable.callable", { link = "@function" })
		set_hl("@lsp.typemod.variable.defaultLibrary", { link = "@variable.builtin" })
		set_hl("@lsp.typemod.variable.injected", { link = "@variable" })
		set_hl("@lsp.typemod.variable.static", { link = "@constant" })
	end,
})
