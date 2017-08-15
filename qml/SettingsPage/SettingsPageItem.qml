import QtQuick 2.6
import QtGraphicalEffects 1.0

Item {
    id: item1
    width: parent.width
    height: 60
    anchors.rightMargin: 8
    anchors.leftMargin: 8
    anchors.right: parent.right
    anchors.left: parent.left
    signal elemClicked(string name)

    Image {
        id:__icon_image
        width: height
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.top: parent.top
        anchors.topMargin: 15
        anchors.left: parent.left
        anchors.leftMargin: 30
        fillMode: Image.PreserveAspectFit
        source: iconImage
        mipmap:true
        ColorOverlay {
            color:"#424242"
            anchors.fill: parent
            enabled: true
            source: parent
        }
    }
    Item{
        id: item2
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: __icon_image.right
        anchors.leftMargin: 30
        Text {
            text: name
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.bold: false
            color:"#000000"
        }

        Rectangle {
            y: 39
            height: 1
            color: "#dcdcdc"
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -1
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: parent.elemClicked(name)
    }
}
