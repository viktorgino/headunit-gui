import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.0
import "../images"

Item {
    id: rear_defrost
    property string imageSrc: "../icons/alert.png"


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
            anchors.rightMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            visible: true
            color: "#ffffff"


        }
    }

    Image {
        id: image3
        anchors.rightMargin: 15
        anchors.leftMargin: 15
        anchors.bottomMargin: 15
        anchors.topMargin: 15
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        Layout.fillHeight: true
        Layout.fillWidth: true
        source:parent.imageSrc
    }

    ColorOverlay {
        id: image3_overlay
        color: "#000000"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.rightMargin: 15
        anchors.leftMargin: 15
        anchors.bottomMargin: 15
        anchors.topMargin: 15
        visible: false
        enabled: true
        source: image3
    }


    MouseArea {
        id: mouseArea1
        anchors.verticalCenter: parent.verticalCenter
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        onClicked: {
            image3_overlay.visible = !image3_overlay.visible
            rectangle2.visible = !rectangle2.visible
        }
    }
}
