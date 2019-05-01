import QtQuick 2.6

import HUDTheme 1.0

Item {
    id: __root
    height: 60
    //width: parent.width
    property int leftPadding: 0
    property var itemData : {
        "label":"",
        "name": "",
        "description": "",
        "iconImage":"",
        "autosave": false
    }
    property var value
    signal push(var qml, var properties)

    ThemeHeaderText {
        id: themeHeaderText
        color: "#1100aa"
        text: __root.itemData.label
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
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
    }

}
