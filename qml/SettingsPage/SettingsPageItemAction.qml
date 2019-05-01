import QtQuick 2.6
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0

import HUDTheme 1.0

SettingsPageItem {
    id:__root
    signal elemClicked()
    itemData : {
        "label":"Action",
        "name": "action",
        "type":"action",
        "action": ""
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            eval(itemData.action)
        }
    }

}
