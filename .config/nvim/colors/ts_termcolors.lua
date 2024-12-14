vim.g.colors_name = "ts_termcolors"

local function set_hl(group, options)
  vim.api.nvim_set_hl(0, group, options)
end

set_hl("Boolean", {bold = true, ctermfg = 3})
set_hl("String", {italic = true, ctermfg = 4})
set_hl("Character", {italic = true, ctermfg = 12})
set_hl("SpecialChar", {bold = true, ctermfg = 12})
set_hl("Comment", {italic = true, ctermfg = 7})
set_hl("Constant", {ctermfg = 5})
set_hl("Special", {ctermfg = 6})
set_hl("Define", {bold = true, ctermfg = 3})
set_hl("Function", {bold = true, ctermfg = 2})
set_hl("PreProc", {ctermfg = 1})
set_hl("Constructor", {ctermfg = 2})
set_hl("Exception", {ctermfg = 9})
set_hl("Macro", {ctermfg = 2})
set_hl("Keyword", {bold = true, ctermfg = 2})
set_hl("Include", {bold = true, ctermfg = 10})
set_hl("Operator", {bold = true})
set_hl("Repeat", {bold = true, ctermfg = 10})
set_hl("StorageClass", {ctermfg = 3})
set_hl("Label", {ctermfg = 12})
set_hl("Type", {ctermfg = 13})
set_hl("Typedef", {ctermfg = 13})
set_hl("Identifier", {ctermfg = 14})
set_hl("Underlined", {underline = true})
set_hl("Structure", {bold = true, ctermfg = 3})
set_hl("Property", {ctermfg = 13})

set_hl("@annotation", {link = "PreProc"})
set_hl("@attribute", {link = "PreProc"})
set_hl("@boolean", {link = "Boolean"})
set_hl("@character", {link = "Character"})
set_hl("@character.printf", {link = "SpecialChar"})
set_hl("@character.special", {link = "SpecialChar"})
set_hl("@comment", {link = "Comment"})
set_hl("@constant", {link = "Constant"})
set_hl("@constant.builtin", {link = "Special"})
set_hl("@constant.macro", {link = "Define"})
set_hl("@constructor", {link = "Constructor"})
set_hl("@diff.delta", {link = "DiffChange"})
set_hl("@diff.minus", {link = "DiffDelete"})
set_hl("@diff.plus", {link = "DiffAdd"})
set_hl("@exception", {link = "Exception"})
set_hl("@field", {link = "String"})
set_hl("@function", {link = "Function"})
set_hl("@function.builtin", {link = "Special"})
set_hl("@function.call", {link = "Function"})
set_hl("@function.macro", {link = "Macro"})
set_hl("@function.method", {link = "Function"})
set_hl("@function.method.call", {link = "Function"})
set_hl("@keyword", {link = "Keyword"})
set_hl("@keyword.conditional", {link = "Conditional"})
set_hl("@keyword.coroutine", {link = "Keyword"})
set_hl("@keyword.debug", {link = "Debug"})
set_hl("@keyword.directive", {link = "PreProc"})
set_hl("@keyword.directive.define", {link = "Define"})
set_hl("@keyword.exception", {link = "Exception"})
set_hl("@keyword.function", {link = "Function"})
set_hl("@keyword.import", {link = "Include"})
set_hl("@keyword.operator", {link = "Operator"})
set_hl("@keyword.repeat", {link = "Repeat"})
set_hl("@keyword.return", {link = "Keyword"})
set_hl("@keyword.storage", {link = "StorageClass"})
set_hl("@label", {link = "Label"})
set_hl("@markup", {link = "Normal"})
set_hl("@markup.emphasis", {link = "Normal"})
set_hl("@markup.environment", {link = "Macro"})
set_hl("@markup.environment.name", {link = "Type"})
set_hl("@markup.heading", {link = "Title"})
set_hl("@markup.italic", {link = "Normal"})
set_hl("@markup.link", {link = "Special"})
set_hl("@markup.link.label", {link = "SpecialChar"})
set_hl("@markup.link.label.symbol", {link = "Identifier"})
set_hl("@markup.link.url", {link = "Underlined"})
set_hl("@markup.list", {link = "Function"})
set_hl("@markup.list.checked", {link = "Function"})
set_hl("@markup.list.markdown", {link = "PreProc"})
set_hl("@markup.list.unchecked", {link = "Macro"})
set_hl("@markup.math", {link = "Special"})
set_hl("@markup.raw", {link = "String"})
set_hl("@markup.raw.markdown_inline", {link = "String"})
set_hl("@markup.strikethrough", {link = "Normal"})
set_hl("@markup.strong", {link = "Normal"})
set_hl("@markup.underline", {link = "Normal"})
set_hl("@method", {link = "Function"})
set_hl("@module", {link = "Include"})
set_hl("@module.builtin", {link = "Include"})
set_hl("@namespace", {link = "Structure"})
set_hl("@namespace.builtin", {link = "Structure"})
set_hl("@none", {})
set_hl("@number", {link = "Number"})
set_hl("@number.float", {link = "Float"})
set_hl("@operator", {link = "Operator"})
set_hl("@preproc", {link = "PreProc"})
set_hl("@property", {link = "Property"})
set_hl("@punctuation.bracket", {link = "Normal"})
set_hl("@punctuation.delimiter", {link = "Normal"})
set_hl("@punctuation.special", {link = "Normal"})
set_hl("@punctuation.special.markdown", {link = "Normal"})
set_hl("@string", {link = "String"})
set_hl("@string.documentation", {link = "Normal"})
set_hl("@string.escape", {link = "String"})
set_hl("@string.regexp", {link = "String"})
set_hl("@symbol", {link = "Character"})
set_hl("@tag", {link = "Label"})
set_hl("@tag.attribute", {link = "Property"})
set_hl("@tag.delimiter", {link = "Property"})
set_hl("@text", {link = "Normal"})
set_hl("@text.bold", {link = "Bold"})
set_hl("@text.danger", {link = "Error"})
set_hl("@text.diff.add", {link = "DiffAdd"})
set_hl("@text.diff.delete", {link = "DiffDelete"})
set_hl("@text.emphasis", {link = "Italic"})
set_hl("@text.environment", {link = "Bold"})
set_hl("@text.environment.name", {link = "Bold"})
set_hl("@text.literal", {link = "Character"})
set_hl("@text.math", {link = "Float"})
set_hl("@text.note", {link = "Label"})
set_hl("@text.reference", {link = "Tag"})
set_hl("@text.strike", {link = "Normal"})
set_hl("@text.strong", {link = "Bold"})
set_hl("@text.title", {link = "Title"})
set_hl("@text.todo", {link = "Exception"})
set_hl("@text.underline", {link = "Underlined"})
set_hl("@text.uri", {link = "Underlined"})
set_hl("@type", {link = "Type"})
set_hl("@type.builtin", {link = "Type"})
set_hl("@type.definition", {link = "Typedef"})
set_hl("@type.qualifier", {link = "Keyword"})
set_hl("@variable", {link = "Variable"})
set_hl("@variable.builtin", {link = "Variable"})
set_hl("@variable.member", {link = "Variable"})
set_hl("@variable.parameter", {link = "Variable"})
set_hl("@variable.parameter.builtin", {link = "Variable"})

-- Lualine
local ts_termcolors = {
  normal = {
    a = {link = "LineNr", bg = 1, gui = 'bold'},
    b = {link = "LineNr", bg = 9},
    c = {link = "LineNr"},
  },
  insert = {
    a = {link = "LineNr", bg = 2, gui = 'bold'},
    b = {link = "LineNr", bg = 10},
    c = {link = "LineNr", bg = 10},
  },
  replace = {
    a = {link = "LineNr", bg = 3, gui = 'bold'},
    b = {link = "LineNr", bg = 11},
    c = {link = "LineNr", bg = 11},
  },
  visual = {
    a = {link = "LineNr", bg = 4, gui = 'bold'},
    b = {link = "LineNr", bg = 12},
    c = {link = "LineNr", bg = 12},
  },
  command = {
    a = {link = "LineNr", bg = 5, gui = 'bold'},
    b = {link = "LineNr", bg = 13},
    c = {link = "LineNr", bg = 0},
  },
  inactive = {
    a = {link = "LineNr", bg = 8, gui = 'bold'},
    b = {link = "LineNr", bg = 8},
    c = {link = "LineNr", bg = 0},
  },
}
require("lualine").setup({ options = { theme = ts_termcolors } })

-- vim: ts=2 sw=2 tw=120
