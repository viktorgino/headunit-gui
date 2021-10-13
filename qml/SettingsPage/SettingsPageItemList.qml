import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0
import QtQml 2.11

import HUDTheme 1.0

Item {
    id: __root

    property bool autoSave: false
    property bool enableIcons : true

    property alias model: listView.model
    property var settings : ({})
    signal push(var qml, var properties)
    signal pop()

    property var settingsShadow : ({})
    property var conditions : ({})

    Component.onDestruction: {
        save();
    }

    function save() {
        for(var key in settingsShadow){
            if(settingsShadow[key] !== settings[key])
                settings[key] = settingsShadow[key]
        }
    }

    function back() {
        pop()
    }
    ListView {
        id: listView
        anchors.fill: parent

        ScrollBar.vertical: ThemeScrollBar { }
        function updateConditionals() {
            for(var currentItem in listView.contentItem.children){
                var targetItem = listView.contentItem.children[currentItem]
                if(targetItem.item){
                    targetItem.visible = targetItem.checkTarget(targetItem.item.name)
                }
            }
        }

        delegate: Loader {
            id:loader
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.rightMargin: listView.ScrollBar.vertical.width
            clip: true

            Connections {
                ignoreUnknownSignals: true
                target: loader.item
                onValueChanged: {
                    if(__root.autoSave){
                        __root.settings[target.name] = target.value
                    } else {
                        __root.settingsShadow[target.name] = target.value
                    }
                    listView.updateConditionals()
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
            Connections{
                target: __root
                onSettingsShadowChanged : {
                    parent.parentSettings = __root.settingsShadow
                }
            }

            function isConditionTrue(name, target){
                if(target in __root.settingsShadow){
                    return __root.settingsShadow[target] === __root.conditions[name].value
                } else {
                    return __root.settings[target] === __root.conditions[name].value
                }
            }

            function checkTarget(name){
                if(__root.conditions[name]){
                    var target = __root.conditions[name].target

                    if(target in __root.conditions){
                        return checkTarget(target) & isConditionTrue(name, target);
                    } else {
                        return isConditionTrue(name, target);
                    }
                }
                return true;
            }

            Component.onCompleted: {
                if(!(modelData.type in settingPageMapping)){
                    return;
                }
                setSource(settingPageMapping[modelData.type], modelData)

                if(item){
                    item.value = __root.settings[modelData.name]
                    item.enableIcon = __root.enableIcons
                }
            }
        }
        onModelChanged : {
            for(var i = 0; i < model.length; i++){
                if(model[i].conditional){
                    __root.conditions[model[i].name] = {
                        "target": model[i].conditionTarget,
                        "value": model[i].conditionValue
                    }
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
