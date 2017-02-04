import QtQuick 2.0

Item {
    id: __media_container_list_item
    height: 50
    width: parent.width
    property var path_parts: modelData.path.split("/")
    property var name: path_parts.splice(-1,1)[0]
    property var path: path_parts.join("/")
    signal itemClicked(string item_type,int id)
    Image {
        id: image1
        width: height
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        fillMode: Image.PreserveAspectCrop
        source:modelData.thumbnail == ""?"qrc:/qml/images/music_placeholder.jpg":"file:/"+modelData.thumbnail
    }
    Text {
        id: label1
        height: 20
        color: "#ffffff"
        text: name
        clip: true
        verticalAlignment: Text.AlignVCenter
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.right: more_button.left
        anchors.rightMargin: 10
        font.pointSize: 11
        anchors.left: image1.right
        anchors.leftMargin: 10
        font.bold: true
    }


    Text {
        id: label2
        color: "#ffffff"
        text: path
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        font.bold: true
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.topMargin: 0
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        anchors.top: label1.bottom
        anchors.left: image1.right
        font.pointSize: 9
        anchors.right: more_button.left
        verticalAlignment: Text.AlignVCenter
    }

    MouseArea {
        id: mouseArea
        anchors.right: more_button.left
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.rightMargin: 10
        onClicked: __media_container_list_item.itemClicked(modelData.item_type,modelData.id)
    }



    Item {
        id: more_button
        width: height
        anchors.rightMargin: 10
        anchors.bottomMargin: 5
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top

        Image {
            anchors.fill: parent
            source: "qrc:/qml/icons/svg/navicon-round.svg"
            fillMode: Image.PreserveAspectCrop
        }
    }

    Rectangle {
        id: rectangle
        height: 1
        color: "#4cffffff"
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
    }

}
