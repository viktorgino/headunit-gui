import QtQuick 2.6
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import HUDTheme 1.0
Item {
    property var value
    property var itemData : {
            "label":"Button",
            "name": "button",
            "iconImage":"",
            "values": [
                {"label":"Save","action":"console.log(\"Save!\")"},
                {"label":"Close","action":"console.log(\"Close!\")"}
            ]
        }

    RowLayout {
        id: rowLayout
        anchors.fill: parent
        Repeater{
            model:itemData.values
            Item{
                Layout.fillHeight: true
                Layout.fillWidth: true
                Button {
                    text: modelData.label
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked: {
                        eval(modelData.action)
                    }
                }
            }
        }
    }
}
