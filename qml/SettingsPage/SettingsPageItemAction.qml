import QtQuick 2.6
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0

import HUDTheme 1.0

SettingsPageItem {
    id:__root
    signal elemClicked()

    property string action: ""
    MouseArea {
        anchors.fill: parent
        onClicked: {
//            eval(__root.action)
        }
    }

}
