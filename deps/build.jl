
@static if !Sys.iswindows()
    error("ViSaGe is only compatiable with Windows.")
end

const depfile = joinpath(@__DIR__, "deps.jl")

if isfile(depfile)
    @eval module DepFile; include($depfile); end
else
    @eval module DepFile; VSGhome=Winhome=""; end
end

try
    VSG_Home = get(ENV, "VSG_HOME", DepFile.VSGhome)
    WIN_Home = if haskey(ENV, "CYGWIN_HOME")
            joinpath(ENV["CYGWIN_HOME"], "usr", "x86_64-w64-mingw32", "sys-root", "mingw", "include")
        else
            get(ENV, "WIN_HOME", DepFile.Winhome)
        end

    VSG_Home = isempty(VSG_Home) ? "C:\\Program Files\\Cambridge Research Systems\\VSGV8\\Windows\\Demonstrations\\MSVC\\x64\\" : VSG_Home
    WIN_Home = isempty(WIN_Home) ? "C:\\cygwin64\\usr\\x86_64-w64-mingw32\\sys-root\\mingw\\include" : WIN_Home

    if !isdir(VSG_Home)
        error("VSG_Home not found ($(VSG_Home))")
    elseif !isdir(WIN_Home)
        error("WIN_Home not found\n($(WIN_Home)); Please make sure you have all the necessary packages installed in Cygwin")
    end

    if DepFile.VSGhome != VSG_Home || DepFile.Winhome != WIN_Home
        open(depfile, "w") do f
            println(f, "const VSGhome = \"", escape_string(VSG_Home), '"')
            println(f, "const Winhome = \"", escape_string(WIN_Home), '"')
        end
    end
catch
    if isfile(depfile)
        rm(depfile, force=true) # delete on error
    end
    rethrow()
end