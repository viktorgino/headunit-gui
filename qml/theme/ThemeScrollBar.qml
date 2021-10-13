import QtQuick 2.11
import QtQuick.Controls 2.4

ScrollBar {
    id: __root
    width: 15
    visible: __root.size < 1.0 && __root.policy !== ScrollBar.AlwaysOff
    contentItem: Item {
        Rectangle {
            width: parent.width > parent.height ? parent.height : parent.width
            height: width
            color: HUDStyle.Colors.formText
            radius: width / 2

        }
        Rectangle {
            id: rectangle
            x : parent.width > parent.height ? parent.height / 2 : 0
            y : parent.width > parent.height ? 0 : parent.width / 2
            width: parent.width > parent.height ? parent.width - parent.height : parent.width
            height: parent.width > parent.height ? parent.height : parent.height - parent.width
            color: "#ffffff"
        }

        Rectangle {
            width: (parent.width > parent.height ? parent.height : parent.width)
            height: width
            color: HUDStyle.Colors.formText
            radius: width / 2
            x: parent.width > parent.height ? parent.width - width: 0
            y: parent.width > parent.height ? 0 : parent.height - height

        }

    }
    background : Rectangle {
        id:background
        width: 1
        height : __root.height
        x : (__root.width / 2 ) - width
        color: Qt.lighter(HUDStyle.Colors.formText, 0.4)
    }
    onPositionChanged : {
    }
}
