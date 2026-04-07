using PlutoSliderServer

println("Starting/deploying for users...")

println(ARGS)

# must be a number for Pluto?!
host = length(ARGS) ≥ 1 ? ARGS[1] : "0.0.0.0" # "0.0.0.0"
port = length(ARGS) ≥ 2 ? parse(Int, ARGS[2]) : 8042

PlutoSliderServer.run_notebook("src/StrongC3.jl",
    SliderServer_host=host, SliderServer_port=port	)
# host="0.0.0.0" would also work.
