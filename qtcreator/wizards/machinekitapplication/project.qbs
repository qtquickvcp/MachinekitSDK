import qbs

MachinekitApplication {
    name: "%{ProjectName}"
    halFiles: ["%{ProjectName}.hal"]
@if "%{BBIO}" == "true"
    bbioFiles: ["%{ProjectName}.bbio"]
@endif
@if "%{MACHINEKITINI}" == "true" && "%{LINUXCNCINI}" == "true" && "%{LAUNCHERINI}" == "true"
    configFiles: ["%{ProjectName}.ini", "machinekit.ini", "launcher.ini"]
    machinekitIni: ["machinekit.ini"]
    launcherIni: ["launcher.ini"]
    linuxcncIni: ["%{ProjectName}.ini"]
@elsif "%{MACHINEKITINI}" == "true" && "%{LINUXCNCINI}" == "true"
    configFiles: ["%{ProjectName}.ini", "machinekit.ini"]
    machinekitIni: ["machinekit.ini"]
    linuxcncIni: ["%{ProjectName}.ini"]
@elsif "%{MACHINEKITINI}" == "true" && "%{LAUNCHERINI}" == "true"
    configFiles: ["launcher.ini", "machinekit.ini"]
    machinekitIni: ["machinekit.ini"]
    launcherIni: ["launcher.ini"]
@elsif "%{LINUXCNCINI}" == "true" && "%{LAUNCHERINI}" == "true"
    configFiles: ["%{ProjectName}.ini", "launcher.ini"]
    launcherIni: ["launcher.ini"]
    linuxcncIni: ["%{ProjectName}.ini"]
@elsif "%{LINUXCNCINI}" == "true" && "%{MACHINEKITINI}" == "true"
    configFiles: ["%{ProjectName}.ini", "machinekit.ini"]
    machinekitIni: ["machinekit.ini"]
    linuxcncIni: ["%{ProjectName}.ini"]
@elsif "%{MACHINEKITINI}" == "true"
    configFiles: ["machinekit.ini"]
    machinekitIni: ["machinekit.ini"]
@elsif "%{LAUNCHERINI}" == "true"
    configFiles: ["launcher.ini"]
    launcherIni: ["launcher.ini"]
@elsif "%{LINUXCNCINI}" == "true"
    configFiles: ["%{ProjectName}.ini"]
    linuxcncIni: ["%{ProjectName}.ini"]
@endif
}
