import QtQuick 2.11
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import QtQml 2.11

import HUDTheme 1.0

Item {
    id: __root
    height: 40
    property var value : ""

    property string name : ""
    property alias label : title.text
    property alias description : subtitle.text
    property alias iconImage : itemIcon.iconImage
    property bool enableIcon: true

    signal push(var qml, var properties)

    Item {
        id:__wrapper
        width: subtitle.width>title.width?itemIcon.width+subtitle.width:itemIcon.width+title.width
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0


        ThemeFormText {
            id: title
            height: subtitle.text === ""?40:20
            text: "Title"
            anchors.leftMargin: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.top: parent.top
            anchors.left: itemIcon.right
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        }

        ThemeFormText {
            id: subtitle
            text: ""
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            verticalAlignment: Text.AlignTop
            anchors.left: itemIcon.right
            anchors.top: title.bottom
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            anchors.topMargin: 2
            subtext: true
        }

        SettingsPageItemIcon {
            id:itemIcon
            width: enableIcon?height:0
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 0
            anchors.bottomMargin: 0
        }
    }
}


