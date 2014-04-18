import qbs

Product {
    property var qmlFiles
    property string targetDir: "/home/linuxcnc/test"
    property string importsDir: "."
    property string applicationType: "ui"

    name: "MachinekitUI"
    type: "application"
    qbsSearchPaths: "../"

    qbs.installPrefix: targetDir

    Depends { name: "Qt.core" }
    Depends { name: "Qt.quick" }
    Depends { name: "Qt.qml" }
    Depends { name: "hal" }
    //Depends { name: "cpp" }

    Group {
        name: "QML files"
        condition: ((files != undefined) && (files.length != 0))
        files: qmlFiles
        overrideTags: false
        qbs.install: true
        qbs.installDir: ""
    }
    Group {
        condition: true
        fileTagsFilter: ["application", "mainqml"]
        qbs.install: true
        qbs.installDir: ""
    }
}
