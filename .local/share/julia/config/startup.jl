# Setup OhMyREPL and Revise
import Pkg
let
        pkgs = ["Revise", "OhMyREPL", "Crayons", "VimBindings"]
        for pkg in pkgs
                if Base.find_package(pkg) === nothing
                        Pkg.add(pkg)
                end
        end
end
try
        using Revise
        using OhMyREPL
        using Crayons
        import OhMyREPL:Passes.SyntaxHighlighter

        scheme = SyntaxHighlighter.ColorScheme()
        SyntaxHighlighter.symbol!(scheme, Crayon(foreground = 009))
        SyntaxHighlighter.comment!(scheme, Crayon(foreground = 007))
        SyntaxHighlighter.string!(scheme, Crayon(foreground = 013))
        SyntaxHighlighter.call!(scheme, Crayon(foreground = 012))
        SyntaxHighlighter.op!(scheme, Crayon(foreground = 001))
        SyntaxHighlighter.keyword!(scheme, Crayon(foreground = 0011))
        SyntaxHighlighter.macro!(scheme, Crayon(foreground = 002))
        SyntaxHighlighter.function_def!(scheme, Crayon(foreground = 003))
        SyntaxHighlighter.text!(scheme, Crayon(foreground = 008))
        SyntaxHighlighter.error!(scheme, Crayon(foreground = 015))
        SyntaxHighlighter.argdef!(scheme, Crayon(foreground = 004))
        SyntaxHighlighter.number!(scheme, Crayon(foreground = 009))
        SyntaxHighlighter.add!("Wal", scheme)
        colorscheme!("Wal")

        if isinteractive()
                @eval using VimBindings
        end

catch err
        @warn "Could not load startup packages."
end
