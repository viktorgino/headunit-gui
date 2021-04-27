import QtQuick 2.11
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0

import QtQml 2.11
import HUDTheme 1.0

SettingsPageItem {
    id:__root
    property var value : 0
//    itemData : {
//        "label":"Combo Box",
//        "name": "combobox",
//        "iconImage":"",
//        "values": [],
//        "saveByValue" : false,
//        "provider" : "", // plugin, theme
//        "providerName" : "",
//        "providerProperty" : ""
//    }
    property var values: []
    property bool saveByValue: false
    property string provider: "" // plugin, theme
    property string providerName: ""
    property string providerProperty: ""

    //Set combobox value when its first set
//    Connections {
//        target:__root
//        enabled:true
//        onValueChanged: {
//            comboBox.model = comboBox.setModel()
//            comboBoxConnection.enabled = true
//            enabled = false
//        }
//    }

//    Connections {
//        id:providerConnection
//        enabled: false
//        ignoreUnknownSignals: true
//        onSettingsProviderUpdated: {
//            comboBox.model = comboBox.setModel()
//        }
//    }

//    Connections{
//        id:comboBoxConnection
//        target: comboBox
//        enabled:false
//        onCurrentIndexChanged:{
//            if(Array.isArray(__root.values) && __root.saveByValue){
//                __root.value = __root.values[comboBox.currentIndex]
//            } else {
//                __root.value = Object.keys(__root.values)[comboBox.currentIndex]
//            }
//        }
//    }

//    onValuesChanged: {
//        comboBox.model = comboBox.setModel()
//        if(__root.provider && __root.providerName && __root.providerProperty){
//            switch(__root.provider) {
//            case "plugin" :
//                providerConnection.target = HUDPlugins.plugins[__root.providerName]
//                providerConnection.enabled = true;
//                break;
//            case "theme" :
//                break;
//            }
//        }
//    }

    onValueChanged: {
        if(Array.isArray(__root.values)){
            if(__root.saveByValue){
                comboBox.currentIndex = __root.values.indexOf(__root.value)
            } else {
                comboBox.currentIndex = __root.value
            }

        } else {
            comboBox.currentIndex = Object.keys(__root.values).indexOf(__root.value)
        }
    }

    ComboBox {
        id: comboBox
        anchors.rightMargin: parent.width * 0.05 + 8
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        model : {
            if(__root.provider === "plugin"){
                __root.values = HUDPlugins.getPluginProperty(__root.providerName, __root.providerProperty);
            }
            return Object.keys(__root.values).map(
                        function(key){
                            return __root.values[key]
                        }
                        );
        }

//        onModelChanged: {
//            var maxWidth = 0;

//            model.forEach(function(item, index, array) {
//                var current = String(item).length * 7;
//                if(maxWidth < current){
//                    maxWidth = current;
//                }
//            })
//            width = maxWidth + 60;
//        }
        onCurrentIndexChanged:{
            if(Array.isArray(__root.values) && __root.saveByValue){
                __root.value = __root.values[comboBox.currentIndex]
            } else {
                __root.value = Object.keys(__root.values)[comboBox.currentIndex]
            }
        }
//        function setModel() {
//            //Populate comboBox values if we're using a provider
//            if(__root.provider === "plugin"){
//                __root.values = HUDPlugins.getPluginProperty(__root.providerName, __root.providerProperty);
//            }

//            if(Array.isArray(__root.values)){
//                if(__root.saveByValue){
//                    currentIndex = __root.values.indexOf(__root.value)
//                } else {
//                    currentIndex = __root.value
//                }

//            } else {
//                currentIndex = Object.keys(__root.values).indexOf(__root.value)
//            }

//            return Object.keys(__root.values).map(
//                        function(key){
//                            return __root.values[key]
//                        }
//                        );
//        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
