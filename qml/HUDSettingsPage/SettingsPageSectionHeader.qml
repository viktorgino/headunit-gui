import QtQuick 2.6
import QtGraphicalEffects 1.0

import HUDTheme 1.0
Item{
    id: item1
    height: 40
    clip: true
    width: parent.width

    ThemeHeaderText {
        anchors.rightMargin: 8
        anchors.leftMargin: 8
        anchors.right: parent.right
        anchors.left: parent.left
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        font.bold: true
        level : 3
        text: qsTr(section)
    }

    Rectangle {
        width: parent.width
        height: 1
        color: "#dcdcdc"
    }
}
