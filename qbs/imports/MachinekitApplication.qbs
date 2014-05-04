import qbs

Product {
    property stringList halFiles
    property stringList configFiles
    property stringList bbioFiles
    property stringList pythonFiles
    property stringList compFiles
    property stringList otherFiles
    property path projectDir: "/home/linuxcnc/projects/"
    property path targetDir: projectDir + project.name
    property string applicationType: "hal"
    property var uis

    name: "MachinekitApplication"
    type: ["application"]
    //qbsSearchPaths: "../"

    qbs.installPrefix: targetDir

    //Depends { name: "Qt.quick" }
    //Depends { name: "Qt.qml" }
    Depends { name: "hal" }
    //Depends { name: "cpp" }

    Group {
        name: "HAL files"
        condition: ((files != undefined) && (files.length != 0))
        //fileTagsFilter: ["hal"]
        files: halFiles
        overrideTags: false
        //fileTags: ["hal"]
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
        qbs.installDir: "python"
    }

    Group {
        name: "RT components"
        condition: ((files != undefined) && (files.length != 0))
        files: compFiles
        overrideTags: false
        qbs.install: true
        qbs.installDir: "comp"
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
        condition: true
        fileTagsFilter: ["application"]
        qbs.install: true
        qbs.installDir: ""
    }
    Group {
        condition: true
        fileTagsFilter: ["appconfig"]
        qbs.install: true
        qbs.installDir: ""
    }
}
