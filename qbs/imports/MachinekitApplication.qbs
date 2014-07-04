import qbs

Product {
    property stringList halFiles: []
    property stringList configFiles: []
    property stringList bbioFiles: []
    property stringList pythonFiles: []
    property stringList compFiles: []
    property stringList otherFiles: []
    property stringList uis: []
    property string uiDir: "uis"
    property string machinekitIni: ""
    property string linuxcncIni: ""
    property string display: ""
    property bool enableRemote: true
    property path projectDir: "/home/machinekit/projects"
    property path machinekitDir: ""
    property path targetDir: projectDir + "/" + product.name
    property int debugLevel: 5


    name: "MachinekitApplication"
    type: "application"

    qbs.installPrefix: targetDir

    Depends { name: "hal" }

    Group {
        name: "HAL files"
        condition: ((files != undefined) && (files.length != 0))
        files: halFiles
        overrideTags: false
        qbs.install: true
        qbs.installDir: ""
    }

    Group {
        name: "Config files"
        condition: ((files != undefined) && (files.length != 0))
        files: configFiles
        overrideTags: false
        qbs.install: true
        qbs.installDir: ""
    }

    Group {
        name: "BB IO files"
        condition: ((files != undefined) && (files.length != 0))
        files: bbioFiles
        overrideTags: false
        qbs.install: true
        qbs.installDir: ""
    }

    Group {
        name: "Python components"
        condition: ((files != undefined) && (files.length != 0))
        files: pythonFiles
        overrideTags: false
        qbs.install: true
        qbs.installDir: ""
    }

    Group {
        name: "RT components"
        condition: ((files != undefined) && (files.length != 0))
        files: compFiles
        overrideTags: false
        qbs.install: true
        qbs.installDir: ""
    }

    Group {
        name: "Other files"
        condition: ((files != undefined) && (files.length != 0))
        files: otherFiles
        overrideTags: false
        qbs.install: true
        qbs.installDir: ""
    }

    Group {
        name: "UIs"
        condition: ((files != undefined) && (files.length != 0))
        files: uis
        overrideTags: false
        qbs.install: true
        qbs.installDir: uiDir
    }

    Group {
        condition: true
        fileTagsFilter: ["application"]
        qbs.install: true
        qbs.installDir: ""
    }
}
