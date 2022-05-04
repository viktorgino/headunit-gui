import QtQuick 2.0
import HUDTheme 1.0
import HUDPlugins 1.0
Item {

    Rectangle {
        id: rectangle1
        color: "#00ffffff"
        radius: 5
        border.color: "#ffffff"
        border.width: 5
        anchors.fill: parent
        visible : BottomBarModel.editing
        ImageIcon {
            id: image
            width: 30
            height: 30
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            source: "image://icons/arrow-left-b"
        }

        Rectangle {
            id: rectangle
            height: 2
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.leftMargin: 10
        }

        ImageIcon {
            id: image1
            width: 30
            height: 30
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            source: "image://icons/arrow-right-b"
        }
    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}D{i:2}D{i:3}
}
##^##*/
