import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0

import HUDTheme 1.0

SettingsPageItem {
    id: __root
    property alias value : slider.value

    itemData : {
        "label":"Slider",
        "name": "slider",
        "default":1,
        "minimum": 0,
        "maximum": 100,
        "stepSize":1,
        "unit": ""
    }

    ThemeFormText {
        id:text2
        width: 60
        height: parent.height/2
        text: itemData.prefix + " " + slider.value + " " + itemData.suffix
        anchors.verticalCenter: parent.verticalCenter
        verticalAlignment: Text.AlignVCenter
        anchors.right: parent.right
        anchors.top: parent.top
    }

    Slider{
        id:slider
        width: parent.width/2
        anchors.rightMargin: 8
        anchors.leftMargin: parent.leftPadding
        anchors.verticalCenter: parent.verticalCenter
        padding: 7
        from: itemData.minimum
        to: itemData.maximum
        stepSize: itemData.stepSize
        anchors.left: parent.left
        anchors.right: text2.left
        wheelEnabled: true
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
