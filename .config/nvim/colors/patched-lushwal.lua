--[[ Patched Lushwal Colorscheme ]]

-- First we will need lush, and the colorscheme we wish to modify
local lush = require("lush")
local lushwal = require("lushwal.base")
local get_colors = require("lushwal.colors")

vim.o.background = "dark"
vim.g.colorscheme_name = "patched-lushwal"

local colors = get_colors()

if colors ~= nil then
	vim.g.terminal_color_0 = colors.color0
	vim.g.terminal_color_1 = colors.color1
	vim.g.terminal_color_2 = colors.color2
	vim.g.terminal_color_3 = colors.color3
	vim.g.terminal_color_4 = colors.color4
	vim.g.terminal_color_5 = colors.color5
	vim.g.terminal_color_6 = colors.color6
	vim.g.terminal_color_7 = colors.color7
	vim.g.terminal_color_8 = colors.color8
	vim.g.terminal_color_9 = colors.color9
	vim.g.terminal_color_10 = colors.color10
	vim.g.terminal_color_11 = colors.color11
	vim.g.terminal_color_12 = colors.color12
	vim.g.terminal_color_13 = colors.color13
	vim.g.terminal_color_14 = colors.color14
	vim.g.terminal_color_15 = colors.color15

	-- we can apply modifications ontop of the existing colorscheme
	local spec = lush.extends({ lushwal }).with(
		function()
			return {
				Comment { gui = "italic" }, -- any comment
				CursorLineNr { gui = "bold" }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.

				-- -- These groups are not listed as default vim groups,
				-- -- but they are defacto standard group names for syntax highlighting.
				-- -- commented out groups should chain up to their "preferred" group by
				-- -- default,
				-- -- Uncomment and edit if you want more specific syntax highlighting.
				--
				-- Constant { fg = colors.color1 }
				-- String { gui = "italic" },    --   a string constant: "this is a string"
				-- Character { String },                             --  a character constant: 'c', '\n'
				-- Number { fg = colors.color4 },                    --   a number constant: 234, 0xff
				-- Boolean { gui = "italic" },               --  a boolean constant: TRUE, false
				-- Float { Number },                                 --    a floating point constant: 2.3e10

				-- Identifier { fg = colors.color1 },                -- (preferred) any variable name
				-- Function { fg = colors.color9 },                  -- function name (also: methods for classes)

				Statement { gui = "bold" }, -- (preferred) any statement
				-- Conditional  { }, --  if, then, else, endif, switch, etc.
				-- Repeat       { }, --   for, do, while, etc.
				-- Label        { }, --    case, default, etc.
				-- Operator     { }, -- "sizeof", "+", "*", etc.
				-- Keyword      { }, --  any other keyword
				-- Exception    { }, --  try, catch, throw

				-- PreProc { },     -- (preferred) generic Preprocessor
				-- Include      { }, --  preprocessor #include
				-- Define       { }, --   preprocessor #define
				-- Macro        { }, --    same as Define
				-- PreCondit    { }, --  preprocessor #if, #else, #endif, etc.

				Type { gui = "italic" }, -- (preferred) int, long, char, etc.
				-- StorageClass { }, -- static, register, volatile, etc.
				-- Structure    { }, --  struct, union, enum, etc.
				-- Typedef      { }, --  A typedef

				Special { gui = "bold" },      -- (preferred) any special symbol
				-- SpecialChar  { }, --  special character in a constant
				-- Tag          { }, --    you can use CTRL-] on this
				Delimiter {},                           --	character that needs attention
				SpecialComment { Comment, gui = "NONE" }, -- special things inside a comment
				-- Debug        { }, --    debugging statements

				-- ("Ignore", below, may be invisible...)
				-- Ignore       { }, -- (preferred) left blank, hidden	|hl-Ignore|

				-- These groups are for the native LSP client. Some other LSP clients may
				-- use these groups, or use their own. Consult your LSP client's
				-- documentation.

				-- LspReferenceText           { ColorColumn }, -- used for highlighting "text" references
				-- LspReferenceRead           { ColorColumn }, -- used for highlighting "read" references
				-- LspReferenceWrite          { ColorColumn }, -- used for highlighting "write" references
				-- LspCodeLens                { LineNr },

				-- DiagnosticError            { Error },
				-- DiagnosticWarn             { WarningMsg },
				-- DiagnosticInfo             { fg = p.water },
				-- DiagnosticHint             { fg = p.blossom },
				-- DiagnosticOk               { fg = p.leaf },
				-- DiagnosticDeprecated       { DiagnosticWarn },
				-- DiagnosticUnnecessary      { DiagnosticWarn },
				--
				-- DiagnosticSignError        { SignColumn, fg = DiagnosticError.fg },
				-- DiagnosticSignWarn         { SignColumn, fg = DiagnosticWarn.fg },
				-- DiagnosticSignInfo         { SignColumn, fg = DiagnosticInfo.fg },
				-- DiagnosticSignHint         { SignColumn, fg = DiagnosticHint.fg },
				-- DiagnosticSignOk           { SignColumn, fg = DiagnosticOk.fg },

				-- DiagnosticVirtualTextError { DiagnosticError, bg = DiagnosticError.fg.saturation(8).lightness(p1.bg.l + 4) },
				-- DiagnosticVirtualTextWarn  { DiagnosticWarn, bg = DiagnosticWarn.fg.saturation(8).lightness(p1.bg.l + 4) },
				-- DiagnosticVirtualTextInfo  { DiagnosticInfo, bg = DiagnosticInfo.fg.saturation(8).lightness(p1.bg.l + 4) },
				-- DiagnosticVirtualTextHint  { DiagnosticHint, bg = DiagnosticHint.fg.saturation(8).lightness(p1.bg.l + 4) },
				-- DiagnosticVirtualTextOk    { DiagnosticOk, bg = DiagnosticOk.fg.saturation(8).lightness(p1.bg.l + 4) },

				-- DiagnosticUnderlineError   { fg = opt.colorize_diagnostic_underline_text and DiagnosticError.fg or "NONE", gui = "undercurl", sp = DiagnosticError.fg },
				-- DiagnosticUnderlineWarn    { fg = opt.colorize_diagnostic_underline_text and DiagnosticWarn.fg or "NONE", gui = "undercurl", sp = DiagnosticWarn.fg },
				-- DiagnosticUnderlineInfo    { fg = opt.colorize_diagnostic_underline_text and DiagnosticInfo.fg or "NONE", gui = "undercurl", sp = DiagnosticInfo.fg },
				-- DiagnosticUnderlineHint    { fg = opt.colorize_diagnostic_underline_text and DiagnosticHint.fg or "NONE", gui = "undercurl", sp = DiagnosticHint.fg },
				-- DiagnosticUnderlineOk      { fg = opt.colorize_diagnostic_underline_text and DiagnosticOk.fg or "NONE", gui = "undercurl", sp = DiagnosticOk.fg },

				-- Tree-sitter
				sym "@variable" { Identifier },
				sym "@variable.builtin" { Number },
				sym "@variable.parameter" { sym "@variable" },
				sym "@variable.member" { sym "@variable" },

				sym "@constant" { Identifier, gui = "bold" },
				sym "@constant.builtin" { Number },
				sym "@constant.macro" { Number },

				sym "@module" { Number },
				sym "@module.builtin" { sym "@module" },
				sym "@label" { Statement },

				sym "@string" { Constant },
				sym "@string.documentation" { sym "@string" },
				sym "@string.regexp" { Constant },
				sym "@string.escape" { Special },
				sym "@string.special" { Special },
				sym "@string.special.symbol" { Identifier },
				sym "@string.special.url" { sym "@string.special" },
				sym "@string.special.path" { sym "@string.special" },

				sym "@character" { Constant },
				sym "@character.special" { Special },

				sym "@boolean" { Number },
				sym "@number" { Number },
				sym "@number.float" { sym "@number" },

				sym "@type" { Type },
				sym "@type.builtin" { sym "@type" },
				sym "@type.definition" { sym "@type" },
				sym "@type.qualifier" { sym "@type" },

				sym "@attribute" { PreProc },
				sym "@property" { Identifier },

				sym "@function" { Function },
				sym "@function.builtin" { Special },
				sym "@function.call" { sym "@function" },
				sym "@function.macro" { PreProc },

				sym "@function.method" { sym "@function" },
				sym "@function.method.call" { sym "@function" },

				sym "@constructor" { Special },
				sym "@operator" { Statement },

				sym "@keyword.coroutine" { Statement },
				sym "@keyword.function" { Statement },
				sym "@keyword.operator" { Statement },
				sym "@keyword.import" { PreProc },
				sym "@keyword.storage" { Type },
				sym "@keyword.repeat" { Statement },
				sym "@keyword.return" { Statement },
				sym "@keyword.debug" { Special },
				sym "@keyword.exception" { Statement },

				sym "@keyword.conditional" { Statement },
				sym "@keyword.conditional.ternary" { sym "@keyword.conditional" },
				sym "@keyword.directive" { PreProc },
				sym "@keyword.directive.define" { sym "@keyword.directive" },

				sym "@punctuation.delimiter" { Delimiter },
				sym "@punctuation.bracket" { Delimiter },
				sym "@punctuation.special" { Delimiter },

				sym "@comment" { Comment },
				sym "@comment.documentation" { sym "@comment" },

				sym "@comment.error" { Error },
				sym "@comment.warning" { WarningMsg },
				sym "@comment.todo" { Todo },
				sym "@comment.note" { DiagnosticInfo },

				sym "@markup.strong" { Bold },
				sym "@markup.italic" { Italic },
				sym "@markup.strikethrough" { gui = "strikethrough" },
				sym "@markup.underline" { Underlined },

				sym "@markup.heading" { Title },

				sym "@markup.quote" { fg = colors.foreground },
				sym "@markup.math" { Special },
				sym "@markup.environment" { PreProc },

				sym "@markup.link" { Constant },
				sym "@markup.link.label" { Special },
				sym "@markup.link.url" { Constant },

				sym "@markup.raw" { Constant },
				sym "@markup.raw.block" { sym "@markup.raw" },

				sym "@markup.list" { Special },
				sym "@markup.list.checked" { sym "@markup.list" },
				sym "@markup.list.unchecked" { sym "@markup.list" },

				sym "@diff.plus" { DiffAdd },
				sym "@diff.minus" { DiffDelete },
				sym "@diff.delta" { DiffChange },

				sym "@tag" { Special },
				sym "@tag.attribute" { sym "@property" },
				sym "@tag.delimiter" { Delimiter },

				sym "@none" {},

				sym "@punctuation.special.markdown" { Special },
				sym "@string.escape.markdown" { SpecialKey },
				sym "@markup.link.markdown" { Identifier, gui = "underline" },
				sym "@markup.italic.markdown" { Italic },
				sym "@markup.title.markdown" { Statement },
				sym "@markup.raw.markdown" { Type },
				sym "@markup.link.url.markdown" { SpecialComment },

				sym "@markup.link.vimdoc" { Identifier, gui = "underline" },
				sym "@markup.raw.block.vimdoc" { fg = 'NONE' },
				sym "@variable.parameter.vimdoc" { Type },
				sym "@label.vimdoc" { Type, gui = "bold" },

				-- LSP Semantic Token Groups
				sym "@lsp.type.boolean" { sym "@boolean" },
				sym "@lsp.type.builtinType" { sym "@type.builtin" },
				sym "@lsp.type.comment" { sym "@comment" },
				sym "@lsp.type.decorator" { sym "@attribute" },
				sym "@lsp.type.deriveHelper" { sym "@attribute" },
				sym "@lsp.type.enum" { sym "@type" },
				sym "@lsp.type.enumMember" { sym "@constant" },
				sym "@lsp.type.escapeSequence" { sym "@string.escape" },
				sym "@lsp.type.formatSpecifier" { sym "@markup.list" },
				sym "@lsp.type.generic" { sym "@variable" },
				sym "@lsp.type.interface" { sym "@type" },
				sym "@lsp.type.keyword" { Statement },
				sym "@lsp.type.lifetime" { sym "@keyword.storage" },
				sym "@lsp.type.namespace" { sym "@module" },
				sym "@lsp.type.number" { sym "@number" },
				sym "@lsp.type.operator" { sym "@operator" },
				sym "@lsp.type.parameter" { sym "@variable.parameter" },
				sym "@lsp.type.property" { sym "@property" },
				sym "@lsp.type.selfKeyword" { sym "@variable.builtin" },
				sym "@lsp.type.selfTypeKeyword" { sym "@variable.builtin" },
				sym "@lsp.type.string" { sym "@string" },
				sym "@lsp.type.typeAlias" { sym "@type.definition" },
				sym "@lsp.type.unresolvedReference" { gui = "undercurl", sp = Error.fg },
				sym "@lsp.type.variable" {},
				sym "@lsp.typemod.class.defaultLibrary" { sym "@type.builtin" },
				sym "@lsp.typemod.enum.defaultLibrary" { sym "@type.builtin" },
				sym "@lsp.typemod.enumMember.defaultLibrary" { sym "@constant.builtin" },
				sym "@lsp.typemod.function.defaultLibrary" { sym "@function.builtin" },
				sym "@lsp.typemod.keyword.async" { sym "@keyword.coroutine" },
				sym "@lsp.typemod.keyword.injected" { Statement },
				sym "@lsp.typemod.macro.defaultLibrary" { sym "@function.builtin" },
				sym "@lsp.typemod.method.defaultLibrary" { sym "@function.builtin" },
				sym "@lsp.typemod.operator.injected" { sym "@operator" },
				sym "@lsp.typemod.string.injected" { sym "@string" },
				sym "@lsp.typemod.struct.defaultLibrary" { sym "@type.builtin" },
				sym "@lsp.typemod.type.defaultLibrary" { sym "@type" },
				sym "@lsp.typemod.typeAlias.defaultLibrary" { sym "@type" },
				sym "@lsp.typemod.variable.callable" { sym "@function" },
				sym "@lsp.typemod.variable.defaultLibrary" { sym "@variable.builtin" },
				sym "@lsp.typemod.variable.injected" { sym "@variable" },
				sym "@lsp.typemod.variable.static" { sym "@constant" },

				helpHyperTextEntry { Type, gui = "bold" },
				helpHyperTextJump { Identifier, gui = "underline" },
				helpSpecial { Type },
				helpOption { Constant },

				-- Lazy
				LazyH1({ fg = colors.foreground, bg = colors.background, gui = "bold" }),
				LazyH2({ fg = colors.foreground, bg = colors.background, gui = "bold" }),
				LazyComment({ fg = colors.color3, bg = colors.background, gui = "italic" }),
				LazyNormal({ fg = colors.foreground, bg = colors.background }),
				Commit({ fg = colors.color1, bg = colors.background }),
				LazyCommitIssue({ fg = colors.color1, bg = colors.background, gui = "italic" }),
				LazyCommitType({ fg = colors.color9, bg = colors.background }),
				LazyCommitScope({ fg = colors.color9, bg = colors.background, gui = "italic" }),
				LazyDimmed({ fg = colors.color7, bg = colors.background }),
				LazyProp({ fg = colors.color2, bg = colors.background }),
				LazyValue({ fg = colors.color3, bg = colors.background }),
				LazyNoCond({ fg = colors.color4, bg = colors.background }),
				LazyLocal({ fg = colors.color5, bg = colors.background }),
				LazyProgressDone({ fg = colors.color8, bg = colors.background }),
				LazyProgressTodo({ fg = colors.color7, bg = colors.background }),
				LazySpecial({ fg = lushwal.Type.fg, bg = colors.background }),
				LazyReasonRuntime({ fg = colors.color7, bg = colors.background }),
				LazyReasonPlugin({ fg = colors.color7, bg = colors.background, gui = "italic" }),
				LazyReasonEvent({ fg = colors.color7, bg = colors.background, gui = "italic" }),
				LazyReasonKeys({ fg = colors.color7, bg = colors.background }),
				LazyReasonStart({ fg = colors.color7, bg = colors.background, gui = "bold" }),
				LazyReasonSource({ fg = colors.colory, bg = colors.background, gui = "bold" }),
				LazyReasonFt({ fg = colors.color7, bg = colors.background }),
				LazyReasonCmd({ fg = colors.color7, bg = colors.background }),
				LazyReasonImport({ fg = colors.color7, bg = colors.background, gui = "italic" }),
				LazyReasonRequire({ fg = colors.color7, bg = colors.background, gui = "italic" }),
				LazyButton({ fg = colors.foreground, bg = colors.background, gui = "bold" }),
				LazyButtonActive({ fg = colors.foreground, bg = colors.background, gui = "bold" }),
				LazyTaskOutput({ fg = colors.foreground, bg = colors.background }),
				LazyTaskError({ fg = colors.color1, bg = colors.background }),
				LazyDir({ fg = colors.color4, bg = colors.background }),
				LazyUrl({ fg = colors.color5, bg = colors.background }),

				-- Mason
				MasonNormal({ fg = colors.color1, bg = colors.background }),
				MasonHeader({ fg = colors.foreground, bg = colors.background, gui = "bold" }),
				MasonHeaderSecondary({ fg = colors.foreground, bg = colors.background, gui = "bold" }),
				MasonHighlight({ fg = colors.color3, bg = colors.background }),
				MasonHighlightBlock({ fg = colors.color3, bg = colors.color8 }),
				MasonHighlightBlockBold({ fg = colors.color3, bg = colors.color8, gui = "bold" }),
				MasonHighlightSecondary({ fg = colors.color2, bg = colors.background }),
				MasonHighlightBlockSecondary({ fg = colors.color2, bg = colors.color7 }),
				MasonHighlightBlockBoldSecondary({ fg = colors.color2, bg = colors.color7, gui = "bold" }),
				MasonLink({ fg = colors.color5, bg = colors.background }),
				MasonMuted({ fg = colors.color7, bg = colors.background }),
				MasonMutedBlock({ fg = colors.color7, bg = colors.background }),
				MasonMutedBlockBold({ fg = colors.color7, bg = colors.background, gui = "bold" }),
				MasonError({ fg = colors.background, bg = colors.foreground, gui = "bold" }),
				MasonWarning({ fg = colors.background, bg = colors.foreground, gui = "bold" }),
				MasonHeading({ fg = colors.foreground, bg = colors.background, gui = "bold" }),
			}
		end)

	-- then pass the extended spec to lush for application
	lush(spec)
end
