import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0
import QtQml 2.11

import HUDTheme 1.0
import HUDPlugins 1.0

Item {
    id: __root
    clip: true
    property string currentMenuItem: ""

    Rectangle {
        color: HUDStyle.colors.formBackground
        anchors.fill: parent
    }

    StackView {
        id: settingsPageStack
        anchors.topMargin: 16
        anchors.top: header.bottom
        anchors.right: parent.right
        anchors.rightMargin: 16
        anchors.left: parent.left
        anchors.leftMargin: 16
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 16
        initialItem: settingsPluginList
    }

    Component {
        id: stackComponent
        Loader {
            id: stackLoader
            property QtObject pluginContext
            property QtObject pluginSettings
            Connections {
                ignoreUnknownSignals: true
                target: stackLoader.item
                onPush: {
                    settingsPageStack.push(stackComponent)
                    settingsPageStack.currentItem.setSource(qml, properties)
                }
                onPop: {
                    settingsPageStack.pop()
                }
            }
            Component.onDestruction: {
                if (settingsPageStack.depth === 1 && currentMenuItem != "") {
                    PluginList.callSlot(currentMenuItem,
                                        "onSettingsPageDestroyed")
                    currentMenuItem = ""
                }
            }
        }
    }

    Component {
        id: settingsPageList
        SettingsPageItemList {
            onPush: {
                if (qml === "SettingsPageItemList") {
                    properties.settings = settings[properties.name]
                    settingsPageStack.push(settingsPageList, properties)
                } else {
                    settingsPageStack.push(stackComponent)
                    settingsPageStack.currentItem.setSource(qml, properties)
                    //settingsPageStack.push(qml, properties)
                }
            }
            onPop: {
                settingsPageStack.pop()
            }
            Component.onDestruction: {
                if (settingsPageStack.depth === 1 && currentMenuItem != "") {
                    PluginList.callSlot(currentMenuItem,
                                        "onSettingsPageDestroyed")
                    currentMenuItem = ""
                }
            }
        }
    }

    Component {
        id: settingsPluginList
        ListView {
            width: __root.width
            model: PluginListModel {
                plugins: PluginList
                listType: "SettingsMenu"
            }
            delegate: SettingsPageItemItems {
                width: __root.width
                items: settingsMenu.items
                label: model.label + " Settings"
                iconImage: model.icon

                name: model.name

                onPush: {
                    currentMenuItem = name
                    if (settingsMenu.type === "items") {
                        settingsPageStack.push(settingsPageList, {
                                                   "model": settingsMenu.items,
                                                   "name": model.name,
                                                   "settings": settings
                                               })
                    } else if (settingsMenu.type === "loader") {
                        settingsPageStack.push(stackComponent)
                        settingsPageStack.currentItem.setSource(
                                    settingsMenu.source, {
                                        "pluginContext": contextProperty,
                                        "pluginSettings": settings
                                    })
                    }
                }
            }
            ScrollBar.vertical: ThemeScrollBar {}
        }
    }

    Item {
        id: header
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: parent.height * 0.15
        anchors.leftMargin: 0

        Item {
            id: item2
            anchors.bottomMargin: -20
            anchors.fill: parent

            RectangularGlow {
                id: effect
                anchors.fill: rect
                glowRadius: 20
                spread: -0.1
                color: "#000000"
                cornerRadius: 0
            }

            Rectangle {
                id: rect
                color: HUDStyle.colors.formBox
                clip: true
                anchors.bottomMargin: 20
                anchors.fill: parent
            }
        }

        Image {
            id: image
            width: height
            height: parent.height / 2
            anchors.leftMargin: width / 2
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            anchors.left: parent.left
            source: settingsPageStack.depth
                    === 1 ? "image://icons/android-settings" : "image://icons/android-arrow-back"
            mipmap: true

            ColorOverlay {
                color: "#ffffff"
                anchors.fill: parent
                enabled: true
                source: parent
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (typeof settingsPageStack.currentItem.back === "function") {
                        settingsPageStack.currentItem.back()
                    } else if (settingsPageStack.currentItem.item
                               && (typeof settingsPageStack.currentItem.item.back === "function")) {
                        settingsPageStack.currentItem.item.back()
                    } else if (settingsPageStack.depth > 0) {
                        settingsPageStack.pop()
                    }
                }
            }
        }

        ThemeHeaderText {
            id: text1
            text: qsTr("Settings")
            anchors.leftMargin: image.width / 2
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: image.right
            anchors.right: parent.right
            anchors.rightMargin: 15
        }
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/

