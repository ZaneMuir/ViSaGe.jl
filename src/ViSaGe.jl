module ViSaGe

using Preferences
using CBinding

const VSGhome_set_as_preference = @has_preference("VSGhome")
const Winhome_set_as_preference = @has_preference("Winhome")

if VSGhome_set_as_preference || Winhome_set_as_preference
    if !(VSGhome_set_as_preference && Winhome_set_as_preference)
        error("ViSaGe: either both VSGhome and Winhome must be set or neigher of them")
    end

    const VSGhome = @load_preference("VSGhome")
    const Winhome = @load_preference("Winhome")
else
    const depfile = joinpath(@__DIR__, "..", "deps", "deps.jl")
    if isfile(depfile)
        include(depfile)
    else
        error("ViSaGe not properly installed. Please run Pkg.build(\"ViSaGe\")")
    end
end

if VSGhome == ""
    @info ("""
    No ViSaGe installation found.
    Importing ViSaGe will fail until an installation is configured beforehand.
    """)
    __precompile__(false)
end

c`
-Wall
-I$(Winhome)
-I$(joinpath(VSGhome, "include"))
-L$(joinpath(VSGhome, "lib"))
-lVSGV8
`

c"#include<VSGV8.h>"ji
end
