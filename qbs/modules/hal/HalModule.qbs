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
        condition: product.type.contains("machinekit")
        inputs: ["hal"]

        Artifact {
            fileName: "run.py"
            fileTags: ["machinekit", "application"]
        }

        prepare: {
                var cmd = new JavaScriptCommand();
                cmd.description = "Generating run script " + outputs.machinekit[0].filePath;
                cmd.highlight = "codegen";
                cmd.sourceCode = function() {
                    var file = new TextFile(outputs.machinekit[0].filePath, TextFile.WriteOnly);

                    file.writeLine("#!/usr/bin/python")
                    file.writeLine("")
                    file.writeLine("import sys")
                    file.writeLine("import os")
                    file.writeLine("import subprocess")
                    file.writeLine("from time import *")
                    file.writeLine("import MachinekitLauncher as launcher")
                    file.writeLine("")
                    file.writeLine("launcher.registerExitHandler()")

                    file.writeLine("launcher.setDebugLevel(" + product.debugLevel + ")")

                    if (product.machinekitIni != "")
                        file.writeLine("launcher.setMachinekitIni('" + product.machinekitIni +"')")

                    file.writeLine("os.chdir(os.path.dirname(os.path.realpath(__file__)))")

                    file.writeLine("")
                    file.writeLine("try:")

                    file.writeLine("    launcher.ripEnvironment()")

                    for (var i = 0; i < product.bbioFiles.length; ++i) {
                        file.writeLine("    launcher.loadBbioFile('" + product.bbioFiles[i] + "')")
                    }

                    file.writeLine("    launcher.checkInstallation()")
                    file.writeLine("    launcher.clearSession()")

                    var appList = ""
                    for (var i = 0; i < product.uis.length; ++i) {
                        appList += " '" + product.uiDir + "/" + FileInfo.fileName(product.uis[i]) + "'"
                    }
                    file.writeLine("    launcher.startProcess(\"configserver" + appList +"\")")

                    file.writeLine("    launcher.startRealtime()")

                    // run the file
                    file.writeLine("    launcher.loadHalFile('" + FileInfo.fileName(input.filePath) + "')")

                    file.writeLine("except subprocess.CalledProcessError:")
                    file.writeLine("    sys.exit(1)")
                    file.writeLine("")

                    // loop
                    file.writeLine("while True:")
                    file.writeLine("    sleep(1)")
                    file.writeLine("    launcher.checkProcesses()")

                    file.close();

                    var process = Process()
                    process.exec("chmod", ["+x", outputs.machinekit[0].filePath], false)
                }
                return cmd;
            }
        }

    /*Rule {
        condition: product.type.contains("hal")

        Artifact {
            fileName: "appconfig.ini"
            fileTags: ["appconfig"]
        }

        prepare: {
                var cmd = new JavaScriptCommand();
                cmd.description = "Generating app config " + output.filePath;
                cmd.highlight = "codegen";
                cmd.sourceCode = function() {
                    var file = new TextFile(output.filePath, TextFile.WriteOnly);
                    for (var i = 0; i < product.uis.length; ++i)
                    {
                        file.writeLine(product.uis[i].name)
                    }
                    file.close();
                }
                return cmd;
            }
    }*/

    Rule {
        condition: product.type.contains("linuxcnc")
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
                    file.writeLine(". /home/machinekit/machinekit/scripts/rip-environment")
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
        condition: product.type.contains("ui")
        inputs: ["qml"]

        Artifact {
            fileName: "main.qml"
            fileTags: ["mainqml"]
        }

        prepare: {
                var cmd = new JavaScriptCommand();
                cmd.description = "Generating QML file " + output.filePath;
                cmd.highlight = "codegen";
                cmd.sourceCode = function() {
                    var file = new TextFile(output.filePath, TextFile.WriteOnly);
                    file.write("import QtQuick 2.1 \n \
                                import QtQuick.Controls 1.1 \n \
                                import Machinekit.HalRemote 1.0 \n \
                                import Machinekit.HalRemote.Controls 1.0 \n \
                                ApplicationWindow { \n \
                                visible: true \n \
                                title: connectionWindow.title \n \
                                width: 500 \n \
                                height: 700 \n \
                                ConnectionWindow { \n \
                                id: connectionWindow \n \
                                anchors.fill: parent \n \
                                autoSelectInstance: false \n \
                                applicationSource: \"file:/" + inputs.qml[0].filePath + "\" \n \
                                instanceFilter: ServiceDiscoveryFilter{ name: \"\" } \n \
                                }}")
                    file.close()
                }
                return cmd;
            }
    }

    Rule {
        id: uiRunner
        condition: product.type.contains("ui")
        inputs: ["mainqml"]

        Artifact {
            fileName: "runqml.sh"
            fileTags: ["ui", "application"]
        }

        prepare: {
                var cmd = new JavaScriptCommand();
                cmd.description = "Generating run script " + outputs.ui[0].filePath;
                cmd.highlight = "codegen";
                cmd.sourceCode = function() {
                    var file = new TextFile(outputs.ui[0].filePath, TextFile.WriteOnly);
                    file.writeLine("#!/bin/bash")
                    //file.writeLine("cd " + FileInfo.path(output.filePath))
                    file.writeLine("qmlscene " + FileInfo.fileName(input.filePath)  + " -I " + product.importsDir)
                    file.writeLine("exit 0")
                    file.close();
                    var process = Process()
                    process.exec("chmod", ["+x", outputs.ui[0].filePath], false)
                }
                /*var args = FileInfo.fileName(input.filePath);
                var cmd = new Command("qmlscene", args);
                cmd.description = "running " + FileInfo.fileName(input.filePath);
                cmd.highlight = "linker";
                cmd.workingDirectory = FileInfo.path(input.filePath);*/
                return cmd;
            }
    }
}

