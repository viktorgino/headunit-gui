import QtQuick 2.6

Item {
    id: __media_folder_list_item
    height: 50
    width: parent.width
    function getName (path){
        var path_parts = path.split("/");
        return path_parts.splice(-1,1)[0];
    }
    function getPath (path){
        return path.replace(getName(path),"");
    }

    property var name: getName(modelData.path)
    property var path: getPath(modelData.path)
    signal itemClicked(string item_type,int id,string path, string name, url thumbnail)
    Image {
        id: thumbnail
        width: height
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        fillMode: Image.PreserveAspectCrop
        source:modelData.thumbnail == ""?"qrc:/qml/images/music_placeholder.jpg":"file:/"+modelData.thumbnail
        mipmap:true
    }
    Text {
        id: label1
        height: 20
        color: "#ffffff"
        text: name
        elide: Text.ElideLeft
        clip: true
        verticalAlignment: Text.AlignVCenter
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.right: more_button.left
        anchors.rightMargin: 10
        font.pointSize: 11
        anchors.left: thumbnail.right
        anchors.leftMargin: 10
        font.bold: true
    }


    Text {
        id: label2
        color: "#ffffff"
        text: path
        elide: Text.ElideLeft
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        font.bold: true
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.topMargin: 0
        wrapMode: Text.NoWrap
        anchors.top: label1.bottom
        anchors.left: thumbnail.right
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
        onClicked: __media_folder_list_item.itemClicked(modelData.item_type,modelData.id,path,name,thumbnail.source)
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
            mipmap:true
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
