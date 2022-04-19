import QtQuick 2.6
import QtGraphicalEffects 1.0

import HUDTheme 1.0
SettingsPageItem {
    id:__root
    property alias value : switchButton.checked
//    itemData : {
//        "label":"Switch",
//        "name": "switch",
//        "iconImage": "",
//        "textOff":"Off",
//        "textOn": "On"
//    }

    property string textOff : "Off"
    property string textOn : "On"
    ThemeFormSwitch {
        id:switchButton
        anchors.rightMargin: 40
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
    }

    ThemeFormText {
        id: label
        anchors.right: switchButton.left
        anchors.verticalCenter: switchButton.verticalCenter
        text: switchButton.checked?__root.textOn:__root.textOff
        anchors.rightMargin: 0
        elide: Text.ElideLeft
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
