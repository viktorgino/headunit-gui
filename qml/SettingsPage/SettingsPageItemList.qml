import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0
import QtQml 2.11

import HUDTheme 1.0

Item {
    id: __root
    property int depth: 1
    property alias model: listView.model
    property var settings : ({})
    property string name
    property bool confirmChange: false
    property var settingsShadow : ({})

    Component.onDestruction: {
        if(!confirmChange){
            save();
        }
    }

    function save() {
        for(var key in settingsShadow){
            if(settingsShadow[key] !== settings[key])
                settings[key] = settingsShadow[key]
        }
    }

    signal push(var qml, var properties)
    signal pop()
    function back() {
        pop()
    }
    ListView {
        id: listView
        anchors.fill: parent
        model:({})
        signal listReady();

        delegate: Loader {
            id:loader
            height: 60
            width: __root.width
            Connections {
                ignoreUnknownSignals: true
                target: loader.item
                onValueChanged: {
                    if(target.itemData.autosave && !__root.confirmChange){
                        __root.settings[target.itemData.name] = target.value
                    } else {
                        __root.settingsShadow[target.itemData.name] = target.value
                    }
                }
                onPush: {
                    __root.push(qml,properties)
                }
            }
            property var settingPageMapping: {
                        "items":"SettingsPageItemItems.qml",
                        "loader":"SettingsPageItemLoader.qml",
                        "slider":"SettingsPageItemSlider.qml",
                        "switch":"SettingsPageItemSwitch.qml",
                        "checkbox":"SettingsPageItemCheckbox.qml",
                        "textfield":"SettingsPageItemTextfield.qml",
                        "combobox":"SettingsPageItemCombobox.qml",
                        "button":"SettingsPageItemButtons.qml",
                        "text":"SettingsPageItem.qml",
                        "file":"SettingsPageItemFileBrowser.qml",
                        "color":"SettingsPageItemColor.qml",
                        "header":"SettingsPageItemHeader.qml",
                        "action":"SettingsPageItemAction.qml",
                        "tumbler":"SettingsPageItemTumbler.qml"
            }

            Component.onCompleted: {
                if(!(modelData.type in settingPageMapping)){
                    return;
                }

                if(modelData.type === "color"){
                    modelData.initColor = HUDStyle.Colors[modelData.name]
                }

                var props = {
                    "value" : __root.settings[modelData.name]
                }
                setSource(settingPageMapping[modelData.type], props)

                if(item){
                    item.itemData = Object.assign(item.itemData, modelData); //Not supported in Qt 5.7

//                    //A bit inefficient, but cant change values of maps stored in a QML property
//                    var tempData = modelData
//                    Object.keys(item.itemData).forEach(function (key){
//                        if(!(key in modelData)){
//                            tempData[key] = item.itemData[key]
//                        }
//                    });

//                    item.itemData = tempData

//                    item.value = __root.settings[item.itemData.name]
                }
                listView.listReady()
            }
        }
    }

    RowLayout {
        id: saveButton
        height: __root.confirmChange?60:0
        clip:true
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        visible: __root.confirmChange

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true

            Button {
                id: button
                text: qsTr("Cancel")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    __root.back();
                }
            }
        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true

            Button {
                text: qsTr("Save")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    __root.save();
                    __root.back();
                }
            }
        }
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:5;anchors_width:100;anchors_x:570}
}
 ##^##*/
