import QtQuick 2.6

import HUDTheme 1.0

Item {
    id: __root
    height: 40

    property var value : ""
    property bool enableIcon: true

    property alias label: headerLabel.text
    signal push(var qml, var properties)

    ThemeHeaderText {
        id: headerLabel
        anchors.verticalCenter: parent.verticalCenter
        level: 5
        anchors.left: parent.left
        anchors.leftMargin: 16
    }

    Rectangle {
        id: rectangle
        width: 200
        height: 1
        color: "#969696"
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
    }

}
