import qbs

MachinekitApplication {
    name: "%{ProjectName}"
    halFiles: ["%{ProjectName}.hal"]
@if "%{BBIO}" == "true"
    bbioFiles: ["%{ProjectName}.bbio"]
@endif
@if "%{MACHINEKITINI}" == "true" && "%{LINUXCNCINI}" == "true"
    configFiles: ["%{ProjectName}.ini", "machinekit.ini"]
    machinekitIni: "machinekit.ini"
    linuxcncIni: "%{ProjectName}.ini"
@elsif "%{MACHINEKITINI}" == "true"
    configFiles: ["machinekit.ini"]
    machinekitIni: "machinekit.ini"
@elsif "%{LINUXCNCINI}" == "true"
    configFiles: ["%{ProjectName}.ini"]
    linuxcncIni: "%{ProjectName}.ini"
@endif
}
