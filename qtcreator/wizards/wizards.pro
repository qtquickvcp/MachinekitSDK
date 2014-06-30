TEMPLATE = subdirs

WIZARD_FILES = machinekitapplication \
               qtquickvcpproject \
               halfile \
               bbiofile \
               qtquickvcpapplication

include(../../paths.pri)

wizard_install.files = $$WIZARD_FILES
wizard_install.path = $$QTCREATOR_INSTALL_DIR/share/qtcreator/templates/wizards/

OTHER_FILES += $$WIZARD_FILES

INSTALLS += wizard_install
