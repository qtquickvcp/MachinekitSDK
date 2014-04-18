import qbs 1.0
import qbs.File
import qbs.FileInfo
import qbs.ModUtils
import qbs.TextFile
import qbs.Process

Module {
    property string runFile: "run.sh"

    name: "hal"

    FileTagger {
               patterns: ["*.hal"]
               fileTags: ["hal"]
           }

    FileTagger {
              patterns: ["*.qml"]
              fileTags: ["qml"]
          }

    FileTagger {
              patterns: ["*.comp"]
              fileTags: ["comp"]
          }

    FileTagger {
              patterns: ["*.py"]
              fileTags: ["py"]
          }

    FileTagger {
              patterns: ["*.ini"]
              fileTags: ["ini"]
          }

    Rule {
        id: compiler
        multiplex: true
        inputs: ['hal']
        /*inputs: {
            var tags = ["hal"];
            //if (product.type.contains("application") &&
            //    product.moduleProperty("qbs", "targetOS").contains("darwin") &&
            //    product.moduleProperty("cpp", "embedInfoPlist"))
            //    tags.push("infoplist");
            return tags;
        }*/
        //usings: ["dynamiclibrary_copy", "staticlibrary", "frameworkbundle"]

        //Artifact {
            //fileName: product.destinationDirectory + "/" + product.targetName
        //    fileTags: ["application"]
        //}
        /*Artifact {
            fileName: FileInfo.relativePath(product.buildDirectory, input.filePath)
            fileTags: ["hal"]
        }*/

        /*Artifact {
                    condition: true
                    fileTags: ["application"]
                    fileName: product.destinationDirectory + "/" + product.targetName
                }*/

        prepare: {
            var args = [];
            //args.push(inputs.filePath)
            args.push(input.filePath);
            var cmd = new Command("echo", args);
            cmd.description = 'compiling ' + FileInfo.fileName(input.filePath);
            cmd.highlight = 'compiler';
            return cmd;
        }
    }

    Rule {
            condition: product.applicationType == "hal"
            inputs: ["hal"]

            Artifact {
                fileName: "run.sh"
                fileTags: ["application"]
            }
            prepare: {
                    var cmd = new JavaScriptCommand();
                    cmd.description = "Generating run script " + output.filePath;
                    cmd.highlight = "codegen";
                    cmd.sourceCode = function() {
                        var file = new TextFile(output.filePath, TextFile.WriteOnly);
                        file.writeLine("#!/bin/bash")
                        file.writeLine("export DEBUG=5")
                        file.writeLine(". /home/linuxcnc/machinekit/scripts/rip-environment")
                        file.writeLine("# kill any current sessions")
                        file.writeLine("realtime stop")
                        file.writeLine("cd " + product.targetDir)
                        file.writeLine("halrun -I " + FileInfo.fileName(input.filePath))
                        file.writeLine("exit 0")
                        file.close();
                        var process = Process()
                        process.exec("chmod", ["+x", output.filePath], false)
                    }
                    return cmd;
                }
        }

    Rule {
            condition: product.applicationType == "linuxcnc"
            inputs: ["ini"]
            Artifact {
                fileName: "run.sh"
                fileTags: ["application"]
            }
            prepare: {
                    var cmd = new JavaScriptCommand();
                    cmd.description = "Generating run script " + output.filePath;
                    cmd.highlight = "codegen";
                    cmd.sourceCode = function() {
                        var file = new TextFile(output.filePath, TextFile.WriteOnly);
                        file.writeLine("#!/bin/bash")
                        file.writeLine("export DEBUG=5")
                        file.writeLine(". /home/linuxcnc/machinekit/scripts/rip-environment")
                        file.writeLine("cd " + product.targetDir)
                        file.writeLine("linuxcnc " + FileInfo.fileName(input.filePath))
                        file.writeLine("exit 0")
                        file.close();
                        var process = Process()
                        process.exec("chmod", ["+x", output.filePath], false)
                    }
                    return cmd;
                }
        }

    Rule {
        condition: product.applicationType == "ui"
        inputs: ["qml"]

        Artifact {
            fileName: "main.qml"
            fileTags: ["mainqml"]
        }

        prepare: {
                var cmd = new JavaScriptCommand();
                cmd.description = "Generating run script " + output.filePath;
                cmd.highlight = "codegen";
                cmd.sourceCode = function() {
                    var file = new TextFile(output.filePath, TextFile.WriteOnly);
                    file.writeLine("import QtQuick 2.1")
                    file.writeLine("import QtQuick.Controls 1.1")
                    file.writeLine("ApplicationWindow {")
                    file.writeLine("visible: true")
                    file.writeLine("title: application.title")
                    file.writeLine("width: 600")
                    file.writeLine("height: 800")
                    file.writeLine(FileInfo.baseName(input.filePath) + " {")
                    file.writeLine("id: application")
                    file.writeLine("anchors.fill: parent")
                    file.writeLine("}}")
                    file.close()
                    }
                    return cmd;
                }
    }

    Rule {
            condition: product.applicationType == "ui"
            inputs: ["mainqml"]
            Artifact {
                fileName: "run.sh"
                fileTags: ["application"]
            }
            prepare: {
                    var cmd = new JavaScriptCommand();
                    cmd.description = "Generating run script " + output.filePath;
                    cmd.highlight = "codegen";
                    cmd.sourceCode = function() {
                        var file = new TextFile(output.filePath, TextFile.WriteOnly);
                        file.writeLine("#!/bin/bash")
                        //file.writeLine("cd " + product.targetDir)
                        file.writeLine("qmlscene " + FileInfo.fileName(input.filePath) + " -I " + product.importsDir)
                        file.writeLine("exit 0")
                        file.close();
                        var process = Process()
                        process.exec("chmod", ["+x", output.filePath], false)
                    }
                    return cmd;
                }
        }
}

