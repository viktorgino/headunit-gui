import QtQuick 2.5
import QtGraphicalEffects 1.0


Item{
    id: __root

    property alias source : __image.source
    property alias color:__color.color
    signal clicked()


    Image {
        id:__image
        anchors.fill: parent
        source: parent.imageSource
        fillMode: Image.PreserveAspectFit
        mipmap:true
        visible: false
    }

    ColorOverlay {
        id: __color
        anchors.fill: __image
        enabled: true
        source: __image
        color:HUDStyle.Colors.icon
    }
}
