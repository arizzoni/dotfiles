# Setup OhMyREPL and Revise
import Pkg
let
        pkgs = ["Revise", "OhMyREPL", "VimBindings"]
        for pkg in pkgs
                if Base.find_package(pkg) === nothing
                        Pkg.add(pkg)
                end
        end
end
try
        using Revise
        using OhMyREPL
        
        colorscheme!("Monokai16")

        if isinteractive()
                @eval using VimBindings
        end

catch err
        @warn "Could not load startup packages."
end
