TEMPLATE = subdirs

include(../paths.pri)

MODULE_NAME = hal

IMPORTS_FILES = imports/MachinekitApplication.qbs

MODULES_FILES = modules/hal/HalModule.qbs

imports_install.files = $$IMPORTS_FILES
imports_install.path = $$QTCREATOR_INSTALL_DIR/share/qtcreator/qbs/share/qbs/imports/qbs/base/

modules_install.files = $$MODULES_FILES
modules_install.path = $$QTCREATOR_INSTALL_DIR/share/qtcreator/qbs/share/qbs/modules/$$MODULE_NAME/

INSTALLS += imports_install modules_install
