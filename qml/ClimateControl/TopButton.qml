import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.0
import "../images"

Item {
    id: top_button
    property string imageSrc: "qrc:/qml/icons/alert.png"
    property int margin: height*0.1
    property int ringSize: height*0.05
    function getInnerSquareSide(outterSide){
        return Math.sqrt(2*Math.pow(outterSide/2,2))
    }


    Item {
        id: item1
        anchors.top: parent.top
        anchors.topMargin: top_button.margin
        anchors.bottom: parent.bottom
        anchors.bottomMargin: top_button.margin
        anchors.left: parent.left
        anchors.leftMargin: top_button.margin
        anchors.right: parent.right
        anchors.rightMargin: top_button.margin
        Rectangle {
            id: rectangle2
            color: "#4cffffff"
            radius: height/2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            visible: false
            width:height

            Rectangle {
                id: rectangle1
                radius: height/2
                anchors.right: parent.right
                anchors.rightMargin: top_button.ringSize
                anchors.left: parent.left
                anchors.leftMargin: top_button.ringSize
                anchors.top: parent.top
                anchors.topMargin: top_button.ringSize
                anchors.bottom: parent.bottom
                anchors.bottomMargin: top_button.ringSize
                visible: true
                color: "#ffffff"


            }
        }

        Image {
            id: image3
            width:getInnerSquareSide(rectangle1.height)
            height:getInnerSquareSide(rectangle1.height)
            anchors.horizontalCenter: rectangle2.horizontalCenter
            anchors.verticalCenter: rectangle2.verticalCenter
            fillMode: Image.PreserveAspectFit
            source:top_button.imageSrc
        }

        ColorOverlay {
            id: image3_overlay
            width:getInnerSquareSide(rectangle1.height)
            height:getInnerSquareSide(rectangle1.height)
            color: "#000000"
            anchors.horizontalCenter: rectangle2.horizontalCenter
            anchors.verticalCenter: rectangle2.verticalCenter
            visible: false
            enabled: true
            source: image3
        }


        MouseArea {
            id: mouseArea1
            anchors.fill: parent
            onClicked: {
                image3_overlay.visible = !image3_overlay.visible
                rectangle2.visible = !rectangle2.visible
            }
        }
    }
}
