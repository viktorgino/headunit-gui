import QtQuick 2.11
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0

import QtQml 2.11
import HUDTheme 1.0

SettingsPageItem {
    id:__root
    property var value : 0
    itemData : {
        "label":"Combo Box",
        "name": "combobox",
        "iconImage":"",
        "values": [],
        "saveByValue" : false,
        "provider" : "", // plugin, theme
        "providerName" : "",
        "providerProperty" : ""
    }

    //Set combobox value when its first set
    Connections {
        target:__root
        enabled:true
        onValueChanged: {
            comboBox.setModel()
            comboBoxConnection.enabled = true
            enabled = false
        }
    }

    Connections {
        id:providerConnection
        enabled: false
        ignoreUnknownSignals: true
        onSettingsProviderUpdated: {
            comboBox.setModel();
        }
    }

    Connections{
        id:comboBoxConnection
        target: comboBox
        enabled:false
        onCurrentIndexChanged:{
            if(Array.isArray(itemData.values) && itemData.saveByValue){
                __root.value = itemData.values[comboBox.currentIndex]
            } else {
                __root.value = Object.keys(itemData.values)[comboBox.currentIndex]
            }
        }
    }

    onItemDataChanged: {
        comboBox.setModel();
        if(itemData.provider && itemData.providerName && itemData.providerProperty){
            switch(itemData.provider) {
            case "plugin" :
                providerConnection.target = HUDPlugins.plugins[itemData.providerName]
                providerConnection.enabled = true;
                break;
            case "theme" :
                break;
            }
        }
    }

    ComboBox {
        id: comboBox
        anchors.rightMargin: parent.width * 0.05 + 8
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        onModelChanged: {
            var maxWidth = 0;

            model.forEach(function(item, index, array) {
                var current = String(item).length * 7;
                if(maxWidth < current){
                    maxWidth = current;
                }
            })
            width = maxWidth + 60;
        }
        function setModel() {
            //Populate comboBox values if we're using a provider
            if(itemData.provider === "plugin"){
                itemData.values = HUDPlugins.getPluginProperty(itemData.providerName, itemData.providerProperty);
            }

            if(Array.isArray(itemData.values)){
                if(itemData.saveByValue){
                    currentIndex = itemData.values.indexOf(__root.value)
                } else {
                    currentIndex = __root.value
                }

            } else {
                currentIndex = Object.keys(itemData.values).indexOf(__root.value)
            }

            model = Object.keys(itemData.values).map(
                        function(key){
                            return itemData.values[key]
                        }
                        );
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
