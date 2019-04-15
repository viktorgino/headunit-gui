import QtQuick 2.6
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0

import HUDTheme 1.0

SettingsPageItem {
    id:__root
    property var value : 0
    itemData : {
        "label":"Combo Box",
        "name": "combobox",
        "iconImage":"",
        "values": []
    }

    Connections {
        target:__root
        enabled:true
        onValueChanged: {
            var index;
            if(Array.isArray(itemData.values)){
                index = __root.value
            } else {
                index = Object.keys(itemData.values).indexOf(__root.value)
            }
            comboBox.currentIndex  = index;

            comboBoxConnection.enabled = true
            enabled = false
        }
    }

    Connections{
        id:comboBoxConnection
        target: comboBox
        enabled:false
        onCurrentIndexChanged:{
            __root.value = Object.keys(itemData.values)[comboBox.currentIndex]
        }
    }

    ComboBox {
        id: comboBox
        anchors.rightMargin: parent.width * 0.05 + 8
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        model:Object.keys(itemData.values).map(function(key){return itemData.values[key]})
    }
}
