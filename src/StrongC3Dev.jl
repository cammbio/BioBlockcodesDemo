using Pluto

host = length(ARGS) ≥ 1 ? ARGS[1] : "0.0.0.0"
port = length(ARGS) ≥ 2 ? parse(Int, ARGS[2]) : 8042

invokelatest(Pluto.run(; host, notebook="src/StrongC3.jl"))
# host="0.0.0.0" would also work. 