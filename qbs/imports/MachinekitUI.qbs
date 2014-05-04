import qbs

Product {
    property var qmlFiles
    property path projectDir: "/home/linuxcnc/projects/"
    property path targetDir: projectDir + project.name + "/ui/" + name
    //property string importsDir: "."
    //property string applicationType: "ui"

    name: "MachinekitUI"
    type: "ui"
    //qbsSearchPaths: "../"

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
