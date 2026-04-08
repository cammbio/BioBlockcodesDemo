### A Pluto.jl notebook ###
# v0.20.24

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    return quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ 7fb25a62-0335-11f0-0831-73acf400036f
# ╠═╡ show_logs = false
begin
	using Pkg
	Pkg.activate("..");
	using PlutoUI
	using BioBlockcodes, BioSequences, CairoMakie, GraphMakie
	include("Util.jl")
	btext = "ATC,GGA,CTT"
	nothing
end

# ╔═╡ bf78d69c-6506-43c6-8698-e2b5ce5f3cbe
md"# Strong C3 Codes"

# ╔═╡ ed0de604-5cad-4308-84e1-e1ac31beba64
md"## Input / Settings"

# ╔═╡ 89173b31-6d5a-4073-9c04-003d82d1760b
md"Enter a set of codons separated by commas (,). Then press 'OK'."

# ╔═╡ 8ca25967-6b32-41e2-b88e-9339aab3aba8
begin
	@bind text confirm(TextField((80,4); default=btext), label="Ok")
end

# ╔═╡ 173da41c-db7d-4c3d-8640-e443822b42d6
begin
	codons::Vector{BioSequences.LongSequence{BioSequences.DNAAlphabet{4}}} = [dna"AAT"]
	cgd = CodonGraphData(codons)
	red_codons = []
	try
		global codons, red_codons = parseTupleSet(text)
	catch e
		#return md"$(e)"
		return nothing
	end
	cgd = CodonGraphData(codons)
	if length(red_codons) > 0
		pred_codons = join(red_codons, ",")
		md"Note: There are redundant entries in the input field: $(pred_codons)"
	else
		nothing
	end	
end

# ╔═╡ 67f7c07b-ec9f-4937-9dc6-e3e4e839e4d3
begin
	pcodons = join(codons, ",")
	md"Verified codon set: $(pcodons)"
end

# ╔═╡ 83069ea1-6603-4a45-a6f7-e6d66cd39e4c
md""" Graph layout: $(
		@bind spring PlutoUI.Slider(2:100; default=10, show_value=true)
	)
"""

# ╔═╡ ead28b4f-f8b9-4447-85d9-4c9396977da9
md"## Graph"

# ╔═╡ cbd8207a-c7fe-49e5-be3b-c867d665c70d
begin
	plot_codon_graph(cgd; spring)
end

# ╔═╡ 7d2cf04c-e134-4d3a-b8b5-c5d61c5c73dc
md"comma free: $(is_comma_free(cgd)), circular: $(is_circular(cgd)), C3: $(is_c3(cgd))"

# ╔═╡ 6bb44e18-3bfe-4bea-83fe-ccd98e15b2d8
md"## Extended (Strong) Graph"

# ╔═╡ 3e3864e0-19cb-41ac-8e04-603b4000e261
begin
	cgd2 = deepcopy(cgd)
	_expand_graph!(cgd2)
	plot_codon_graph(cgd2; spring)
end

# ╔═╡ fa4aa6b0-bfc4-45a0-b6f0-5715c95edffc
md"strong circular: $(is_strong_c3(cgd))"

# ╔═╡ 8c946d4f-ed68-4e86-be2e-126d6bc80bfb
md"**GCAT UI** v.0.1.0. (c) 2026 [cammbio institute](https://www.cammbio.th-mannheim.de) and authors mentioned in the source files."

# ╔═╡ 48c26e0a-38fc-4848-ba16-80409f87178c
# Format the web page:
# <!-- works for all submit buttons... TODO -->
html"""
<style>
	main {
		margin: 0 auto;
		max-width: 2000px;
    	padding-left: min(70px, 5%);
    	padding-right: min(70px, 5%);
		h1, h2, h3, h4, h5, h6 {font-family:sans-serif;}
	}
	textarea {
    	font-size: 16px !important;  /* Change to your desired size */
	}
	pluto-helpbox {width: 20vw;}
	input[type*="submit"] {
		width: 100px;
		height: 40px;
		background-color: #33AA33;
	}
</style>
"""

# ╔═╡ Cell order:
# ╟─bf78d69c-6506-43c6-8698-e2b5ce5f3cbe
# ╟─ed0de604-5cad-4308-84e1-e1ac31beba64
# ╟─89173b31-6d5a-4073-9c04-003d82d1760b
# ╟─8ca25967-6b32-41e2-b88e-9339aab3aba8
# ╟─67f7c07b-ec9f-4937-9dc6-e3e4e839e4d3
# ╟─173da41c-db7d-4c3d-8640-e443822b42d6
# ╟─83069ea1-6603-4a45-a6f7-e6d66cd39e4c
# ╟─ead28b4f-f8b9-4447-85d9-4c9396977da9
# ╟─cbd8207a-c7fe-49e5-be3b-c867d665c70d
# ╟─7d2cf04c-e134-4d3a-b8b5-c5d61c5c73dc
# ╟─6bb44e18-3bfe-4bea-83fe-ccd98e15b2d8
# ╟─3e3864e0-19cb-41ac-8e04-603b4000e261
# ╟─fa4aa6b0-bfc4-45a0-b6f0-5715c95edffc
# ╟─8c946d4f-ed68-4e86-be2e-126d6bc80bfb
# ╟─48c26e0a-38fc-4848-ba16-80409f87178c
# ╟─7fb25a62-0335-11f0-0831-73acf400036f
