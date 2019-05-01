TEMPLATE = lib
CONFIG += c++11 plugin link_pkgconfig
QT += qml quick
TARGET = $$qtLibraryTarget(default-theme)

include("../../config.pri")

target.path = $${PREFIX}/themes


SOURCES += \
    plugin.cpp

HEADERS += \
    plugin.h

RESOURCES += default-theme.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

include("quickcross/quickcross.pri")

THEMEFILES += \
    $${PWD}/theme.json \
    $${PWD}/qml/theme/qmldir \
    $${PWD}/qml/theme/designer/hudtheme.metainfo \
    $${PWD}/qml/theme/backgrounds/* \
    $${PWD}/theme.json

#copy needed files to build dir

##recursively copy the theme folder
theme_files_copy.commands = $(COPY_DIR) $$PWD/qml/theme $$OUT_PWD/HUDTheme
##attach the copy command to make target
first.depends = $(first) theme_files_copy
##export variables to global scope
export(first.depends)
export(theme_files_copy.commands)
QMAKE_EXTRA_TARGETS += first theme_files_copy

DISTFILES += THEMEFILES

theme_files.files = $$THEMEFILES
theme_files.path = $${OUT_PWD}/HUDTheme
INSTALLS += target theme_files



