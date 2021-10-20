import QtQuick 2.9
import QtQuick.Controls 2.2

Slider {
    id: control
    value: 0
    height: 20

    property color handleBackgroundColor: HUDStyle.Colors.formBox
    background: Item {
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: control.height
        width: control.availableWidth
        height: implicitHeight
        Rectangle {
            color: HUDStyle.Colors.formBackground
            anchors.fill: parent
            radius: height/2
            border.color: HUDStyle.Colors.formText
            border.width: 1
        }
        Item {
            id: item1
            anchors.fill: parent
            anchors.rightMargin: 2
            anchors.leftMargin: 2
            anchors.bottomMargin: 2
            anchors.topMargin: 2
            Rectangle {
                width: 10 + control.visualPosition * (parent.width - (control.height - 4))
                height: parent.height < width ? parent.height : width
                color: handleBackgroundColor
                radius: height/2
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    handle: Rectangle {
        id:handle
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width - 4) + 2
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: control.height - 4
        implicitHeight: implicitWidth
        radius: height / 2
        color: control.pressed ? "#f0f0f0" : "#f6f6f6"
        border.color: HUDStyle.Colors.formText
        border.width: 1
    }
}

/*##^##
Designer {
    D{i:0;formeditorColor:"#4c4e50";formeditorZoom:3}
}
##^##*/
