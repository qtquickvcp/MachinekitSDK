# Modify these paths to your needs and then build the project

# User local directory
# https://doc-snapshots.qt.io/qbs/cli-config.html
unix:QT_BASE_DIR=$$HOME/.config/QtProject
win32:QT_BASE_DIR=%APPDATA%\QtProject
macx:QT_BASE_DIR=$$HOME/Library/Preferences

# Qt Creator paths for the Qt Quick Designer plugin
# Path to installed Qt Creator (where the plugin should be installed to)
QTCREATOR_INSTALL_DIR=$$QT_BASE_DIR/qtcreator
QBS_INSTALL_DIR=$$QT_BASE_DIR/qbs
# Qt documentation directory containing Qt documentation with .index files
# -> somehow only the Android toolchain comes with .index files
QT_DOC_DIR = $$[QT_INSTALL_PREFIX]/../android_armv7/doc
