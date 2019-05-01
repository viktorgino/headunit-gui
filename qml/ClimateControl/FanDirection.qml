import QtQuick 2.6
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.0
import HUDTheme 1.0

Item{
    id: fan_direction
    Layout.fillHeight: true
    Layout.fillWidth: true


    RowLayout {
        id: arrow_rows
        width: parent.width*0.7
        anchors.bottomMargin: parent.height*0.1
        anchors.topMargin: parent.height*0.1
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.left: parent.left

        Item {
            id: bottom1
            height: parent.width
            Layout.fillHeight: true
            Layout.fillWidth: true

            MouseArea {
                id: bottom_mouse
                width: fan_direction.width
                height: parent.height* 0.3333333
                anchors.bottomMargin: 0
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                onClicked:{
                    bottom_arrow.toggleColor();
                }
            }

            Arrow {
                id: bottom_arrow
                width: parent.width * 1.4
                height: parent.height* 0.3333333
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.bottomMargin: 0
                transformOrigin: Item.Center
                anchors.bottom: parent.bottom
                headSize: width*0.30
                lineSize: width*0.03
            }
        }





        Item {
            id: middle
            height: parent.width
            Layout.fillHeight: true
            Layout.fillWidth: true

            MouseArea {
                id: middle_mouse
                width: fan_direction.width
                height: parent.height* 0.3333333
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: middle_arrow.left
                anchors.leftMargin: 0
                onClicked:{
                    middle_arrow.toggleColor();
                }
            }

            Arrow {
                id: middle_arrow
                width: parent.width * 1.4
                height: parent.height* 0.3333333
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                headSize: width*0.30
                lineSize: width*0.03
            }
        }
        Item {
            id: top1
            height: parent.width
            Layout.fillHeight: true
            Layout.fillWidth: true



            MouseArea {
                id: top_mouse
                width: fan_direction.width
                height: parent.height*0.333333
                anchors.leftMargin: 0
                anchors.left: top_arrow.left
                anchors.top: parent.top
                onClicked:{
                    top_arrow.toggleColor();
                }
            }

            Arrow {
                id: top_arrow
                width: parent.width * 1.4
                height: parent.height* 0.3333333
                anchors.topMargin: 0
                anchors.right: parent.right
                anchors.top: parent.top
                headSize: width*0.30
                lineSize: width*0.03
            }
        }
    }
    Image {
        id: image1
        width: parent.width * 0.7
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        fillMode: Image.PreserveAspectFit
        source: "../icons/svg/seat.svg"
        mipmap:true
    }
}
