import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.0

Item{
    id: item1
    Layout.fillHeight: true
    Layout.fillWidth: true

    Image {
        id: image1
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        source: "../icons/svg/seat.svg"
    }

    GridLayout {
        id: gridLayout1
        width: parent.width*0.6
        height: parent.height * 0.6
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.1
        anchors.left: parent.left
        Layout.fillHeight: true
        Layout.fillWidth: true
        rows: 3
        columns: 6
        columnSpacing: 0
        rowSpacing: 0

        Item {
            id: item5
            Layout.rowSpan: 1
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.columnSpan: 3
        }




        Item {
            id: top
            Layout.columnSpan: 3
            Layout.fillHeight: true
            Layout.fillWidth: true

            Image {
                id: top_image
                visible: true
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                source: "../images/arrow.png"
            }

            ColorOverlay {
                id: top_overlay
                color: "#ff5722"
                anchors.fill: top_image
                enabled: true
                source: top_image
                visible: false
            }

            MouseArea {
                id: top_mouse
                anchors.fill: parent
                onClicked:{
                    top_overlay.visible = !top_overlay.visible
                }
            }
        }



        Item {
            id: down
            Layout.columnSpan: 2
            Layout.rowSpan: 2
            Layout.fillHeight: true
            Layout.fillWidth: true

            Image {
                id: down_image
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                source: "../images/arrow-down.png"
            }

            ColorOverlay {
                id: down_overlay
                color: "#ff5722"
                anchors.fill: down_image
                enabled: true
                source: down_image
                visible: false
            }

            MouseArea {
                id: bottom_mouse
                anchors.fill: parent
                onClicked:{
                    down_overlay.visible = !down_overlay.visible
                }
            }
        }


        Item {
            id: middle
            Layout.columnSpan: 3
            Layout.fillHeight: true
            Layout.fillWidth: true

            Image {
                id: middle_image
                width: parent.width*0.5
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                source: "../images/arrow.png"
            }
            ColorOverlay {
                id: middle_overlay
                color: "#ff5722"
                anchors.fill: middle_image
                visible: false
                enabled: true
                source: middle_image
            }

            MouseArea {
                id: middle_mouse
                anchors.fill: parent
                onClicked:{
                    middle_overlay.visible = !middle_overlay.visible
                }
            }
        }


        Item {
            id: item89
            Layout.rowSpan: 1
            Layout.columnSpan: 1
            Layout.fillHeight: true
            Layout.fillWidth: true
        }


        Item {
            id: item9
            Layout.columnSpan: 4
            Layout.rowSpan: 1
            Layout.fillHeight: true
            Layout.fillWidth: true
        }


    }
}
