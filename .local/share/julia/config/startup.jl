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
        colorscheme!("Monokai16")

catch err
        @warn "Could not load startup packages."
end

atreplinit() do repl
    @eval import REPL
    if !isdefined(repl, :interface)
        repl.interface = REPL.setup_interface(repl)
    end
    REPL.numbered_prompt!(repl)
end
