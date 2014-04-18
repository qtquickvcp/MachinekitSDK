import qbs

Product {
    property var halFiles
    property var configFiles
    property var bbioFiles
    property var pythonFiles
    property var compFiles
    property var otherFiles
    property string targetDir: "/home/linuxcnc/test"
    property string applicationType: "hal"

    name: "MachinekitApplication"
    type: "application"
    qbsSearchPaths: "../"

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

    /*Group {     // Install built files
        name: "Install"
        condition: true
        fileTagsFilter: ["halout"]
        qbs.install: true
        //qbs.installPrefix: "/home/alexander/testinstall"
        qbs.installDir: "hal"
    }*/

    Group {
        condition: true
        fileTagsFilter: ["application"]
        qbs.install: true
        qbs.installDir: ""
    }
}
