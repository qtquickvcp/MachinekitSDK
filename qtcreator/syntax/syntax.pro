TEMPLATE = subdirs

OTHER_FILES = hal.xml

include(../../paths.pri)

files_install.files = $$OTHER_FILES
files_install.path = $$QTCREATOR_INSTALL_DIR/generic-highlighter/

INSTALLS += files_install

copyfiles.input = OTHER_FILES
copyfiles.output = $$OUT_PWD/${QMAKE_FILE_IN_BASE}${QMAKE_FILE_EXT}
copyfiles.commands = $$QMAKE_MKDIR $$dirname(copyfiles.output) $$escape_expand(\n\t) $$QMAKE_COPY ${QMAKE_FILE_IN} ${QMAKE_FILE_OUT}
copyfiles.CONFIG += no_link no_clean
copyfiles.variable_out = PRE_TARGETDEPS
QMAKE_EXTRA_COMPILERS += copyfiles
