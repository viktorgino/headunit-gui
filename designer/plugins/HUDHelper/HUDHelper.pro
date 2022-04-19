TEMPLATE = lib
CONFIG += plugin
QT += qml quick

DESTDIR = ../../backend/HUDHelper
TARGET  = HUDHelper

uri = HUDHelper

SOURCES +=  HUDHelper.cpp

DISTFILES = qmldir

qml.files = qmldir
qml.path = $${DESTDIR}
INSTALLS += target qml
