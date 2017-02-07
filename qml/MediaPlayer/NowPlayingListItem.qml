import QtQuick 2.7

Item {
    id: __now_playing_list_item
    height: 50
    width: parent.width
    property string path: modelData.path + "/" + modelData.name
    property int nowPlaying : 0
    property var nameArr : modelData.name.split("-")
    property string track: nameArr[0]
    property string artist: nameArr.length > 1?nameArr[1]:path

    signal itemClicked(int index)
    Text {
        id: label1
        height: 20
        color: "#ffffff"
        text: track
        fontSizeMode: Text.VerticalFit
        clip: true
        verticalAlignment: Text.AlignVCenter
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.right: more_button.left
        anchors.rightMargin: 10
        font.pointSize: 11
        anchors.left: parent.left
        anchors.leftMargin: 10
        font.bold: true
    }


    Text {
        id: label2
        color: "#ffffff"
        text:artist
        elide: Text.ElideLeft
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        font.bold: true
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.topMargin: 0
        wrapMode: Text.NoWrap
        anchors.top: label1.bottom
        anchors.left: parent.left
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
        onClicked: {
            __now_playing_list_item.itemClicked(index);
        }
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
            source: "qrc:/qml/icons/play.png"
            fillMode: Image.PreserveAspectCrop
            visible: index==nowPlaying
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

