println("Building/compiling Julia project...")
using Pkg
Pkg.activate("/usr/local/bioblockcodes")
# Workaround until these packages are not officially registered:
Pkg.rm("BioBlockcodes")
Pkg.rm("BioCodes")
Pkg.add(url="https://github.com/cammbio/BioCodes.jl.git#v0.1.2")
Pkg.add(url="https://github.com/cammbio/BioBlockcodes.jl.git#v0.1.2")
Pkg.instantiate();
Pkg.build();
println("Done.")
