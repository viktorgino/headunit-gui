import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import HUDTheme 1.0

Slider {
    id: control
    snapMode: RangeSlider.SnapAlways
    from: -15
    to: 15
    stepSize: 1
    property int centerLocation: 0
    property int tickHeight : 100
    property color color : "#ffffff"
    background: Item {
        id: item2
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 200
        width: control.availableWidth
        height : 2
        RowLayout {
            width: control.width
            height: parent.height
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 0
            Repeater {
                model : (control.to - control.from) / control.stepSize + 1
                Item {
                    id: item1
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Rectangle {
                        id : tick
                        height: index % 5 === 0 ? control.tickHeight : control.tickHeight / 2
                        color: control.color
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: 2
                    }

                    ThemeText {
                        color: control.color
                        text: index % 5 === 0 ? control.from + index * control.stepSize : ""
                        anchors.top: tick.bottom
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: tick.horizontalCenter
                    }
                }
            }
        }
        Rectangle {
            id: rectangle
            width: parent.width
            implicitHeight: 4
            height: implicitHeight
            radius: 2
            color: control.color

            Rectangle {
                property real stepCount : Math.abs(control.from - control.to)
                property real zeroPos : Math.abs(control.centerLocation - control.from ) / stepCount
                property real asd : parent.width * zeroPos
                width: Math.abs(parent.width * (zeroPos - control.visualPosition))
                height: parent.height
                x : control.visualPosition >= zeroPos ? parent.width * zeroPos : zeroPos * parent.width - width
                color: "#21be2b"
                radius: 2

            }
        }
    }
    wheelEnabled: true

    handle: Rectangle {
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 10
        implicitHeight: control.tickHeight * 0.8
//        radius: 13
        color: control.color
        border.color: "#000000"
    }
}

/*##^##
Designer {
    D{i:0;formeditorColor:"#4c4e50";width:500}
}
##^##*/
