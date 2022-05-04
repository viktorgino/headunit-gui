import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: __root
    property string label : "Label"
    property bool editing : false
    radius : 10
    border.color: BottomBarModel.editing?"#00ff00":"#ffffff"
    border.width: 5
    color: "#00ffffff"

    Text {
        id: text1
        text: label
        anchors.fill: parent
        font.pixelSize: 400
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        minimumPixelSize: 1
        anchors.rightMargin: 8
        anchors.leftMargin: 8
        anchors.bottomMargin: 8
        anchors.topMargin: 8
        fontSizeMode: Text.Fit
        color: BottomBarModel.editing?"#00ff00":"#ffffff"
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
