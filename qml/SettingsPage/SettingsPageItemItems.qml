import QtQuick 2.6
import QtGraphicalEffects 1.0

import HUDTheme 1.0

SettingsPageItem {
    id: __root
//    itemData : 	{
//        "label":"Items",
//        "name": "items",
//        "iconImage":"",
//        "description":"",
//        "items":[],
//        "confirmChange" : false
//    }
    property var items: []
    property bool autoSave : false
    property bool enableIcons : true

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
            __root.push("SettingsPageItemList", {model:__root.items, name: __root.name, autoSave : __root.autoSave, enableIcons : __root.enableIcons});
        }
    }
}
