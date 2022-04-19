TEMPLATE = lib
CONFIG += c++11 plugin link_pkgconfig
QT += qml quick quickcontrols2
TARGET = $$qtLibraryTarget(default-theme)

include("../../config.pri")

target.path = $${PREFIX}/themes/default-theme

SOURCES += \
    defaulttheme.cpp \
    themeiconprovider.cpp

HEADERS += \
    defaulttheme.h \
    themeiconprovider.h

RESOURCES += default-theme.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH += $${PWD}/qml/theme
QML_IMPORT_PATH += $$OUT_PWD

THEMEFILES += \
    $${PWD}/theme.json \
    $${PWD}/qml/theme/qmldir \
    $${PWD}/qml/theme/designer/hudtheme.metainfo \
    $${PWD}/qml/theme/backgrounds/*

#remove previous theme files
theme_files_remove.commands = rm -rf $$OUT_PWD/HUDTheme

##recursively copy the theme folder
theme_files_copy.commands = $(COPY_DIR) $$PWD/qml/HUDTheme $$OUT_PWD/HUDTheme
theme_files_copy.depends = theme_files_remove

#remove previous settings files
settings_files_remove.commands = rm -rf $$OUT_PWD/HUDSettingsPage
settings_files_remove.depends = theme_files_copy

##recursively copy the setting page folder
settingpage_files_copy.commands = $(COPY_DIR) $$PWD/qml/HUDSettingsPage $$OUT_PWD/HUDSettingsPage
settingpage_files_copy.depends = settings_files_remove

##attach the copy command to make target
first.depends = $(first) theme_files_copy settingpage_files_copy

QMAKE_EXTRA_TARGETS += first theme_files_remove theme_files_copy settings_files_remove settingpage_files_copy
DISTFILES += THEMEFILES \
    theme.json

theme.files = $${PWD}/qml/HUDTheme/*
theme.path = $$PREFIX/themes/default-theme/HUDTheme

settingpage.files = $${PWD}/qml/HUDSettingsPage/*
settingpage.path = $$PREFIX/themes/default-theme/HUDSettingsPage

INSTALLS += target theme settingpage



