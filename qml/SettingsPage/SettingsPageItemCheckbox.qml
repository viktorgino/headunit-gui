import QtQuick 2.6
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0

import HUDTheme 1.0
SettingsPageItem {
    id:__root
    property alias value : checkBox.checked
    itemData : {
            "label":"Checkbox",
            "name": "checkbox",
            "iconImage":""
        }

    CheckBox {
        id: checkBox
        anchors.rightMargin: parent.width * 0.05
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        onCheckedChanged: {
            __root.value = checked
        }
    }
}
