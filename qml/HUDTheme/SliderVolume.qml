import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Shapes 1.15

Item {
    id: __root
    property int value : 10
    property alias maxValue : repeater.model
    property alias spacing : rowLayout.spacing
    RowLayout {
        id: rowLayout

        spacing: width / repeater.count * 0.15
        height : parent.height - 20 > width * 0.4 ? width * 0.4 : parent.height - 20
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.leftMargin: 10

        property real offset : parent.width * 0.02
        property double c : Math.sqrt(Math.pow(width, 2) + Math.pow(height, 2))
        property double beta: Math.abs(Math.asin(width/c))

        Repeater {
            id: repeater
            model: 25

            Item {
                id: item1
                Layout.fillWidth: true
                Layout.fillHeight: true

                Shape {
                    id:triangle
                    anchors.bottom: parent.bottom
                    width:parent.width
                    //                    height: parent.height - rowLayout.spacing * (parent.height / parent.width)
                    height: (rowLayout.height / repeater.count) * (index + 1)
                    property real c : width / Math.sin(rowLayout.beta)
                    property real a : Math.sqrt(Math.pow(c, 2) - Math.pow(width, 2))
                    ShapePath {
                        fillColor: __root.value > index ? "#b9b9b9" : "#00000000"
                        strokeColor: "#b9b9b9"
                        strokeWidth: 2
                        miterLimit: 10
                        startX: 0; startY: triangle.height
                        PathLine { x: 0; y: triangle.a }
                        PathLine { x: triangle.width; y: 0 }
                        PathLine { x: triangle.width; y: triangle.height }
                        PathLine { x: 0; y: triangle.height }
                    }
                }
            }
        }
    }
    MouseArea {
        anchors.fill : rowLayout
        onWheel : {
                if (wheel.angleDelta.y > 0)
                {
                    if (__root.value < repeater.count) {
                        __root.value++
                    }
                }
                else
                {
                    if ( __root.value > 0) {
                        __root.value--
                    }
                }
        }
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;formeditorColor:"#808080";formeditorZoom:1.5;height:300;width:400}
}
##^##*/
