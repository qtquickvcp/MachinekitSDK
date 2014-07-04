import qbs

MachinekitApplication {
    name: "%ProjectName%"
    halFiles: ["%ProjectName%.hal"]
@if "%BBIO%" == "true"
    bbioFiles: ["%ProjectName%.bbio"]
@endif
@if "%MACHINEKITINI%" == "true"
    configFiles: ["machinekit.ini"]
    machinekitIni: "machinekit.ini"
@endif
@if "%LINUXCNCINI%" == "true"
    configFiles: ["%ProjectName%.ini"]
    linuxcncIni: "%ProjectName%.ini"
@endif
}
