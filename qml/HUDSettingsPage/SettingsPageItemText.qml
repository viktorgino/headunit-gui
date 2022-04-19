import QtQuick 2.6
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0

import HUDTheme 1.0
SettingsPageItem {
    id: __root
    height: 60

    property alias label : title.text
//    property var itemData : {
//            "label":"Text",
//            "name": "text",
//            "iconImage": "",
//        }

    SettingsPageItemIcon {
        id:itemIcon
        iconImage: itemData.iconImage
    }

    ThemeFormText {
        id: title
        anchors.left: itemIcon.right
        anchors.verticalCenter: parent.verticalCenter
    }
}
