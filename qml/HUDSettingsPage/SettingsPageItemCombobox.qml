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
    //    property string provider: "" // plugin, theme
    //    property string providerName: ""
    //    property string providerProperty: ""
    // TODO: Get providers working

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
//            if(__root.provider === "plugin"){
//                __root.values = HUDPlugins.getPluginProperty(__root.providerName, __root.providerProperty);
//            }
            return Object.keys(__root.values).map(
                        function(key){
                            return __root.values[key]
                        }
                        );
        }

        onCurrentIndexChanged:{
            if(Array.isArray(__root.values) && __root.saveByValue){
                __root.value = __root.values[comboBox.currentIndex]
            } else {
                __root.value = Object.keys(__root.values)[comboBox.currentIndex]
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
