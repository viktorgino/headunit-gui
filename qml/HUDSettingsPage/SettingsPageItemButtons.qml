import QtQuick 2.6
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import HUDTheme 1.0
Item {
    id:__root
    property var value
    property bool enableIcon: false

    property var values : [
        {"label":"Save","action":"console.log(\"Save!\")"},
        {"label":"Close","action":"console.log(\"Close!\")"}
    ]

    RowLayout {
        id: rowLayout
        anchors.fill: parent
        Repeater{
            model:__root.values
            Item{
                Layout.fillHeight: true
                Layout.fillWidth: true
                Button {
                    text: modelData.label
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked: {
//                        eval(modelData.action)
                    }
                }
            }
        }
    }
}
