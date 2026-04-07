#!/usr/bin/bash
cd /usr/local/bioblockcodes
julia --project=. src/StrongC3Prod.jl $*
