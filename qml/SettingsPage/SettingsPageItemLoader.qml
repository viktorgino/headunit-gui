import QtQuick 2.6
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0

import HUDTheme 1.0

SettingsPageItem {
    id:__root
    signal elemClicked()
    itemData : {
        "label":"Loader",
        "name": "loader",
        "type":"loader",
        "iconImage":""
    }

    ThemeFormText {
        id:text2
        width: parent.width * 0.05
        text:  ">"
        anchors.bottom: parent.bottom
        verticalAlignment: Text.AlignVCenter
        anchors.right: parent.right
        anchors.top: parent.top
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            __root.push(itemData.source, {});
        }
    }

}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:4;anchors_height:480}
}
 ##^##*/
