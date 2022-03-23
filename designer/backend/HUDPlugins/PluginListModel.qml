import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQml.Models 2.15

ListModel {
//    roles[NameRole] = "name";
//    roles[LabelRole] = "label";
//    roles[PluginRole] = "plugin";
//    roles[QmlSourceRole] = "qmlSource";
//    roles[LoadedRole] = "pluginLoaded";
//    roles[MenuRole] = "menu";
//    roles[SettingsRole] = "settings";
//    roles[SettingsItemsRole] = "settingsItems";
//    return roles;
    property string listType : ""
    property var plugins : ""
    ListElement {
        name: "test1"
        label : "Test Plugin"
        plugin : ListElement {
            loaded:true
            qmlSource:"qrc:/HVAC/ClimateControl/ACLayout.qml"
            name:"test1"
            label : "A/C"
            menu : ListElement {
                text:"A/C"
                source:"qrc:/HVAC/ClimateControl/ACLayout.qml"
                image: "qrc:/HVAC/icons/thermometer.svg"
                color:"#673AB7"
            }
        }
        qmlSource : "qrc:/HVAC/ClimateControl/ACLayout.qml"
        pluginLoaded : true
        menu : ListElement {
            text:"A/C"
            source:"qrc:/HVAC/ClimateControl/ACLayout.qml"
            image: "qrc:/HVAC/icons/thermometer.svg"
            color:"#673AB7"
        }
        icon : "qrc:/HVAC/icons/thermometer.svg"

        settings : ""
        settingsItems : ""
    }
}
