# Setup OhMyREPL and Revise
import Pkg
let
        pkgs = ["Revise", "OhMyREPL"]
        for pkg in pkgs
                if Base.find_package(pkg) === nothing
                        Pkg.add(pkg)
                end
        end
end
try
        using Revise
        using OhMyREPL
        # colorscheme!("Monokai24bit")

catch err
        @warn "Could not load startup packages."
end
