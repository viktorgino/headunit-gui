import QtQuick 2.6
import QtGraphicalEffects 1.0

import HUDTheme 1.0

SettingsPageItem {
    id: __root
    itemData : 	{
        "label":"Items",
        "name": "items",
        "iconImage":"",
        "description":"",
        "items":[],
        "confirmChange" : false
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
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            __root.push("SettingsPageItemList", {model:itemData.items, name: itemData.name, confirmChange: itemData.confirmChange});
        }
    }
}
