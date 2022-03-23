import QtQuick 2.0
import QtQuick.Controls 2.0

Switch {
    id: control
    checked: true

    indicator: Rectangle {
        id: rectangle
        implicitWidth: 48
        implicitHeight: 24
        x: control.leftPadding
        y: parent.height / 2 - height / 2
        radius: 13
        color: control.checked ? "#17a81a" : HUDStyle.colors.formBackground
        border.color: control.checked ? "#17a81a" : HUDStyle.colors.formText

        Rectangle {
            x: control.checked ? parent.width - width - 2 : 2
            width: 20
            height: 20
            radius: height/2
            color: control.down ? "#cccccc" : "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            border.color: HUDStyle.colors.formText
            border.width: 1
        }
    }
    contentItem: ThemeText {
        text: control.text
        opacity: enabled ? 1.0 : 0.3
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        leftPadding: control.indicator.width + control.spacing
    }
}
