import QtQuick 2.6
import QtGraphicalEffects 1.0

Item {
    property string iconImage: ""
    height: 60
    width: 60
    Image {
        id:__icon_image
        width: height
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.top: parent.top
        anchors.topMargin: 15
        anchors.left: parent.left
        fillMode: Image.PreserveAspectFit
        source: iconImage
        mipmap:true
        ColorOverlay {
            color:HUDStyle.colors.formText
            anchors.fill: parent
            enabled: true
            source: parent
        }
    }
}
