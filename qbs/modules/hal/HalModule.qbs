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
        inputs: ["hal"]
        multiplex: true

        Artifact {
            filePath: "run.py"
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
                    file.writeLine("import importlib")
                    file.writeLine("from time import *")
                    file.writeLine("from machinekit import launcher")
                    file.writeLine("from machinekit import config")
                    file.writeLine("")
/*                    file.writeLine("def rip_environment(path=None, force=False):")
                    file.writeLine("    if os.getenv('EMC2_PATH') is not None:    # check if already ripped")
                    file.writeLine("        return")
                    file.writeLine("")
                    file.writeLine("    if path is None:")
                    file.writeLine("        command = None")
                    file.writeLine("        scriptFilePath = os.environ['HOME'] + '/.bashrc'")
                    file.writeLine("        if os.path.exists(scriptFilePath):")
                    file.writeLine("            with open(scriptFilePath) as f:    # use the bashrc")
                    file.writeLine("                content = f.readlines()")
                    file.writeLine("                for line in content:")
                    file.writeLine("                    if 'rip-environment' in line:")
                    file.writeLine("                        line = line.strip()")
                    file.writeLine("                        if (line[0] == '.'):")
                    file.writeLine("                            command = line")
                    file.writeLine("")
                    file.writeLine("        scriptFilePath = os.environ['HOME'] + '/machinekit/scripts/rip-environment'")
                    file.writeLine("        if os.path.exists(scriptFilePath):")
                    file.writeLine("            command = '. ' + scriptFilePath")
                    file.writeLine("")
                    file.writeLine("        if (command is None):")
                    file.writeLine("            sys.stderr.write('Unable to rip environment\\n')")
                    file.writeLine("            sys.exit(1)")
                    file.writeLine("    else:")
                    file.writeLine("        command = '. ' + path + '/scripts/rip-environment'")
                    file.writeLine("")
                    file.writeLine("    process = subprocess.Popen(command + ' && env', stdout=subprocess.PIPE, shell=True)")
                    file.writeLine("    for line in process.stdout:")
                    file.writeLine("        (key, _, value) = line.partition('=')")
                    file.writeLine("        os.environ[key] = value.rstrip()")
                    file.writeLine("")
                    file.writeLine("    sys.path.append(os.environ['PYTHONPATH'])")
                    file.writeLine("")
                    file.writeLine("")

                    if (product.machinekitDir == "") {
                        file.writeLine("rip_environment()")
                    } else {
                        file.writeLine("rip_environment(" + product.machinekitDir + ")")
                    }
                    file.writeLine("launcher = importlib.import_module('machinekit.launcher')")
*/
                    file.writeLine("")
                    file.writeLine("launcher.register_exit_handler()")

                    if (product.display !== "") {
                        file.writeLine("os.environ['DISPLAY'] = '" + product.display + "'")
                    }

//                    file.writeLine("launcher.set_debug_level(" + product.debugLevel + ")")

                    if (product.machinekitIni != "")
                        file.writeLine("launcher.set_machinekit_ini('" + product.machinekitIni +"')")

                    file.writeLine("os.chdir(os.path.dirname(os.path.realpath(__file__)))")
                    file.writeLine("c = config.Config()")
                    file.writeLine('os.environ["MACHINEKIT_INI"] = c.MACHINEKIT_INI')

                    file.writeLine("")
                    file.writeLine("try:")

                    file.writeLine("    launcher.check_installation()")
                    file.writeLine("    launcher.cleanup_session()")

                    for (var i = 0; i < product.bbioFiles.length; ++i) {
                        file.writeLine("    launcher.load_bbio_file('" + product.bbioFiles[i] + "')")
                    }

                    for (var i = 0; i < product.compFiles.length; ++i) {
                        file.writeLine("    launcher.install_comp('" + product.compFiles[i] + "')")
                    }

                    if (product.enableRemote) {
                        var appList = ""
                        for (var i = 0; i < product.uis.length; ++i) {
                            appList += " '" + product.uiDir + "/" + FileInfo.fileName(product.uis[i]) + "'"
                        }
                        file.writeLine("    launcher.start_process(\"configserver" + appList +"\")")
                    }

                    if (product.linuxcncIni != "") {    // start linuxcnc
//                        file.writeLine("    launcher.start_process('linuxcnc " + product.linuxcncIni + "')")
                        file.writeLine("    launcher.start_process('halrun -i " + product.linuxcncIni + " -I " + product.halFiles[0] + "')")
                    }
                    else { // start realtime and load hal files
//                        file.writeLine("    launcher.start_realtime()")

                        for (var i = 0; i < product.halFiles.length; ++i) {
//                            file.writeLine("    launcher.load_hal_file('" + product.halFiles[i] + "')")
                            file.writeLine("    launcher.start_process('halrun -I " + product.halFiles[i] + "')")
                        }
                    }

                    file.writeLine("except subprocess.CalledProcessError:")
                    file.writeLine("    launcher.end_session()")
                    file.writeLine("    sys.exit(1)")
                    file.writeLine("")

                    // loop
                    file.writeLine("while True:")
                    file.writeLine("    sleep(1)")
                    file.writeLine("    launcher.check_processes()")

                    file.close();

                    var process = Process()
                    process.exec("chmod", ["+x", outputs.machinekit[0].filePath], false)
                }
                return cmd;
            }
        }
}

