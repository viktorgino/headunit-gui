TEMPLATE = lib
CONFIG += c++11 plugin link_pkgconfig
QT += qml quick
TARGET = $$qtLibraryTarget(default-theme)

include("../../config.pri")

target.path = $${PREFIX}/themes/default-theme

SOURCES += \
    defaulttheme.cpp

HEADERS += \
    defaulttheme.h

RESOURCES += default-theme.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = $$OUT_PWD

THEMEFILES += \
    $${PWD}/theme.json \
    $${PWD}/qml/theme/qmldir \
    $${PWD}/qml/theme/designer/hudtheme.metainfo \
    $${PWD}/qml/theme/backgrounds/*

#copy needed files to build dir

##recursively copy the theme folder
theme_files_copy.commands = $(COPY_DIR) $$PWD/qml/theme $$OUT_PWD/HUDTheme
##attach the copy command to make target
first.depends = $(first) theme_files_copy
##export variables to global scope
export(first.depends)
export(theme_files_copy.commands)
QMAKE_EXTRA_TARGETS += first theme_files_copy

DISTFILES += THEMEFILES \
    theme.json

theme.files = $${PWD}/qml/theme/*
theme.path = $$PREFIX/themes/default-theme/HUDTheme

INSTALLS += target theme



