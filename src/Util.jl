using BioSequences

"""
Reads a string and converts it to a vector of tuples (e.g. codons) of DNA.
"""
function parseTupleVector(text::String)
    rtext = filter(c -> c != 0x0a, text)
    rtext = filter(c -> c != '\n', rtext)
    rtext = filter(c -> c != ' ', rtext)
    rtext = uppercase(rtext)
    rtext = map(c -> c == 'U' ? 'T' : c, rtext)
    rtext = filter(c -> c in ['A', 'C', 'G', 'T', ','], rtext) # Only valid letters

    tuples_string = split(rtext, ",")
    return [LongDNA{4}(c) for c in tuples_string]
end

"""
Reads a string and converts it to a set of tuples (e.g. codons) of DNA.
"""
function parseTupleSet(text::String)
    tuples = parseTupleVector(text)

    function find_duplicates(vec)
        seen = Set{eltype(vec)}()
        duplicates = Set{eltype(vec)}()

        for item in vec
            if item in seen
                push!(duplicates, item)
            else
                push!(seen, item)
            end
        end

        return collect(duplicates)
    end

    d = find_duplicates(tuples)
    tuples_set = unique(tuples)
    return tuples_set, d
end
