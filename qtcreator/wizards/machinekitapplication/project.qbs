import qbs

MachinekitApplication {
    name: "%ProjectName%"
    halFiles: ["%ProjectName%.hal"]
@if "%BBIO%" == "true"
    bbioFiles: ["%ProjectName%.bbio"]
@endif
@if "%MACHINEKITINI%" == "true"
    configFiles: ["%ProjectName%.ini"]
    machinekitIni: "%ProjectName%.ini"
@endif
}
