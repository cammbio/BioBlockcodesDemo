println("Building/compiling Julia project...")
using Pkg
Pkg.activate("/usr/local/bioblockcodes")
# Workaround until this package is officially registered:
Pkg.rm("BioBlockcodes")
Pkg.add(url="https://github.com/cammbio/BioBlockcodes.jl.git#v0.1.3")
Pkg.instantiate();
Pkg.build();
println("Done.")
