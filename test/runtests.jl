using ViSaGe
using Test

function crsInfo()
    chk = vsgInit("")
    @assert chk >= 0 "VSG init failed"

    print_attribute(name, attr) = println("- ", name, ": ", vsgGetSystemAttribute(attr))

    println("==== ViSaGe Attributes ====")

    for (i, j) in [
        ("Device Class", @vsgDEVICECLASS),
        ("Device Version", @vsgDEVICEHWREVISION),
        ("Device Serial#", @vsgDEVICESERIALNUMBER),
        ("VSG Version", @vsgSOFTINSTALLVERSION),
        ("VSL.dll version", @vsgSOFTWAREVERSION),
        ("Card Type", @vsgCARDTYPE),
        ("Frame rate", @vsgFRAMERATE),
        ("Frame max rate", @vsgMAXFRAMERATE),
        ("Frame Time (us)", @vsgFRAMETIME),
        ("Screen line width (um)", @vsgLINEWIDTH),
        ("Screen hight (px)", @vsgSCREENHEIGHT),
        ("Screen width (px)", @vsgSCREENWIDTH),
        ("TTL-IN channels", @vsgNUMDIGITALINBITS),
        ("TTL-OUT channels", @vsgNUMDIGITALOUTBITS),
        ("ADC channels", @vsgNUMANALOGUEINPUTS),
        ("ADC resolution", @vsgANALOGUEINRESOLUTION),
        ("ADC max sampling rate", @vsgMAXADCSAMPLINGRATE),
        ("DAC channels", @vsgANALOGUEOUTRESOLUTION),
        ("DAC resolution", @vsgANALOGUEOUTRESOLUTION),
        ("DAC Color resolution", @vsgCOLOURRESOLUTION),
        ("Host-to-video copy rate (bytes/second)", @vsgHOSTTOVIDEOBLITRATE),
        ("Object-Animation-System maximum number", @vsgNUMOBJECTS),
        ("Video Page Limit", @vsgNUMVIDEOPAGES),
        ("Page Cycling Limit", @vsgPAGECYCLEARRAYSIZE),
    ]
        print_attribute(i, j)
    end
    chk
end

@testset "ViSaGe.jl" begin
    # Write your tests here.
    @test crsInfo() >= 0
end
