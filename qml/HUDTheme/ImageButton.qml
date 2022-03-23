import QtQuick 2.5
import QtGraphicalEffects 1.0


Item{
    id: __root

    property bool checked: false
    property bool checkable: false
    property string text: ""
    property url imageSource
    property url activeImageSource

    property color activeColor: "#ff5722"
    property color pressedColor: Qt.darker(color,1.5);
    property color color:HUDStyle.colors.formText
    signal clicked()

    Image {
        id:__image
        anchors.fill: parent
        source: __root.imageSource
        fillMode: Image.PreserveAspectFit
        mipmap:true
        visible: true
    }

    ColorOverlay {
        id: __color
        color: __root.checked ? __root.activeColor : __root.color
        anchors.fill: __image
        enabled: true
        source: __image
    }

    Text {
        text: parent.text
        color: __root.color
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    MouseArea{
        anchors.fill: parent
        onPressed: {
            __color.color = __root.pressedColor;
        }
        onReleased: {
            if(__root.checkable) {
                __root.checked = !__root.checked;
            }

            __root.update()
            __root.clicked()
        }
    }

    onCheckedChanged : {
        __root.update()
    }

    function update(){
        if(__root.checked){
            __color.color = __root.activeColor;
        } else {
            __color.color = __root.color;
        }

        if(__root.activeImageSource != "") {
            if(__root.checked){
                __image.source = __root.activeImageSource
            } else {
                __image.source = __root.imageSource
            }
        }
    }
}
