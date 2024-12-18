"""Configuration file for IPython."""

from pygments.token import (
    Token,
    Keyword,
    Name,
    Comment,
    String,
    Error,
    Number,
    Operator,
    Generic
)

c = get_config()  # noqa

c.TerminalIPythonApp.auto_create = False
c.TerminalIPythonApp.copy_config_files = False
c.TerminalIPythonApp.display_banner = False
c.TerminalIPythonApp.exec_PYTHONSTARTUP = True
# A list of dotted module names of IPython extensions to load.
#  See also: InteractiveShellApp.extensions
# c.TerminalIPythonApp.extensions = []
# Enable GUI event loop integration with any of ('asyncio', 'glut', 'gtk',
#  'gtk2', 'gtk3', 'gtk4', 'osx', 'pyglet', 'qt', 'qt5', 'qt6', 'tk', 'wx',
#  'gtk2', 'qt4').
#  See also: InteractiveShellApp.gui
c.TerminalIPythonApp.gui = 'gtk4'
c.InteractiveShell.banner1 = ""
c.TerminalInteractiveShell.auto_match = True
c.TerminalInteractiveShell.autoformatter = 'black'
c.TerminalInteractiveShell.banner1 = ""
c.TerminalInteractiveShell.debug = True
c.TerminalInteractiveShell.debugger_history_file = '~/.cache/ipython/pdbhistory'
c.TerminalInteractiveShell.display_completions = 'readlinelike'
c.TerminalInteractiveShell.editing_mode = 'vi'
c.TerminalInteractiveShell.emacs_bindings_in_vi_insert_mode = False
c.TerminalInteractiveShell.highlight_matching_brackets = True
c.InteractiveShell.separate_in = ''
c.TerminalInteractiveShell.highlighting_style_overrides = {
    Token.Text: 'ansiblue',
    Token.Whitespace: 'ansiblack',
    Token.Error: 'ansibrightred',
    Token.Other: 'ansibrightblue',
    Token.Keyword: 'ansiwhite',
    Token.Name: 'ansired',
    Token.Literal: 'ansibrightyellow',
    Token.String: 'ansiyellow',
    Token.Number: 'ansibrightmagenta',
    Token.Operator: 'ansicyan',
    Token.Punctuation: 'ansiblack',
    Token.Comment: 'ansibrightblack',
    Token.Generic: 'ansiwhite',

    Keyword: "ansiwhite",
    Keyword.Constant: "ansiwhite",
    Keyword.Declaration: "bold ansiwhite",
    Keyword.Namespace: "bold italic ansigray",
    Keyword.Pseudo: "ansigray",
    Keyword.Reserved: "italic ansigray",
    Keyword.Type: "italic ansiwhite",

    Name: "ansired",
    Name.Attribute: "italic ansired",
    Name.Builtin: "bold italic ansiblue",
    Name.Builtin.Pseudo: "bold italic ansibrightblue",
    Name.Class: "bold italic ansibrightred",
    Name.Constant: "ansired",
    Name.Decorator: "italic ansiyellow",
    Name.Entity: "ansired",
    Name.Exception: "bold ansired",
    Name.Function: "ansigreen",
    Name.Function.Magic: "italic ansigreen",
    Name.Label: "italic ansired",
    Name.Namespace: "bold italic ansibrightgreen",
    Name.Other: "ansired",
    Name.Property: "italic ansibrightred",
    Name.Tag: "ansibrightred",
    Name.Variable: "ansiblue",
    Name.Variable.Class: "italic ansiblue",
    Name.Variable.Global: "bold ansiblue",
    Name.Variable.Instance: "ansiblue",
    Name.Variable.Magic: "italic ansiblue",

    # Literal: "ansiyellow",
    # Literal.Date: "ansibrightyellow",
    String: "ansicyan",
    String.Affix: "ansicyan",
    String.Backtick: "ansiwhite",
    String.Char: "ansibrightcyan",
    String.Delimiter: "ansiwhite",
    String.Doc: "italic ansigray",
    String.Double: "ansicyan",
    String.Escape: "ansicyan",
    String.Heredoc: "italic ansigray",
    String.Interpol: "italic ansicyan",
    String.Other: "ansicyan",
    String.Regex: "bold ansicyan",
    String.Single: "ansicyan",
    String.Symbol: "ansicyan",
    Number: "ansimagenta",
    Number.Bin: "ansimagenta",
    Number.Float: "ansimagenta",
    Number.Hex: "ansimagenta",
    Number.Integer: "ansimagenta",
    Number.Integer.Long: "ansimagenta",
    Number.Oct: "ansimagenta",

    Operator: "ansiwhite",
    Operator.Word: "bold ansiwhite",

    # Punctuation: "ansiwhite",
    # Punctuation.Marker: "ansiwhite",

    Comment: "italic ansibrightblack",
    Comment.Hashbang: "italic ansibrightblack",
    Comment.Multiline: "italic ansibrightblack",
    Comment.Preproc: "bold noitalic ansibrightblack",
    Comment.PreprocFile: "bold noitalic ansibrightblack",
    Comment.Single: "italic ansibrightblack",
    Comment.Special: "bold noitalic ansibrightblack",

    Generic: "ansiwhite",
    Generic.Deleted: "ansiwhite",
    Generic.Emph: "ansiwhite",
    Generic.Error: "ansiwhite",
    Generic.Heading: "ansiwhite",
    Generic.Inserted: "ansiwhite",
    Generic.Output: "ansiwhite",
    Generic.Prompt: "ansiwhite",
    Generic.Strong: "ansiwhite",
    Generic.EmphStrong: "ansiwhite",
    Generic.Subheading: "ansiwhite",
    Generic.Traceback: "ansiwhite"
}
c.TerminalInteractiveShell.pdb = False
c.TerminalInteractiveShell.prompt_includes_vi_mode = False
# The format for line numbering, will be passed `line` (int, 1 based) the
#  current line number and `rel_line` the relative line number. for example to
#  display both you can use the following template string :
#  c.TerminalInteractiveShell.prompt_line_number_format='{line:
#  4d}/{rel_line:+03d} | ' This will display the current line number, with
#  leading space and a width of at least 4 character, as well as the relative
#  line number 0 padded and always with a + or - sign. Note that whenusingEmacs
#  mode the prompt of the first line may not update.
#  Default: ''
# c.TerminalInteractiveShell.prompt_line_number_format = ''

# Class used to generate Prompt token for prompt_toolkit
#  Default: 'IPython.terminal.prompts.Prompts'
# c.TerminalInteractiveShell.prompts_class = 'IPython.terminal.prompts.Prompts'

#  See also: InteractiveShell.quiet
# c.TerminalInteractiveShell.quiet = False
c.TerminalInteractiveShell.true_color = True
