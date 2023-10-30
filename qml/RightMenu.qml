import QtQuick 2.6
import QtQuick.Layouts 1.0
import Qt.labs.settings 1.0
import QtGraphicalEffects 1.0

import HUDPlugins 1.0
import HUDTheme 1.0

Item {
    id: __root
    signal showSettings

    property int currentIndex: 0
    property bool extendedMenu: false

    Settings {
        property alias currentIndex: __root.currentIndex
        property alias extendedMenu: __root.extendedMenu
    }

    Rectangle {
        color: "#212121"
        anchors.fill: parent
        opacity: 0.4
    }

    Rectangle {
        color: "#212121"
        id: rightMenuOptions
        width: parent.width
        height: 40

        RowLayout {
            anchors.fill: parent
            spacing: 0

            Item {
                Layout.maximumWidth: 32 + 12 + 5
                Layout.fillWidth: true
                Layout.fillHeight: true
                MenuButton {
                    id: menuButton
                    anchors.bottomMargin: 8
                    anchors.topMargin: 8
                    width: height
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    rotation: 180
                    anchors.horizontalCenter: parent.horizontalCenter
                    isActive: __root.extendedMenu
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        __root.extendedMenu = !__root.extendedMenu
                    }
                }
            }
            ImageButton {
                Layout.fillWidth: true
                Layout.fillHeight: true
                imageSource: "image://icons/gear-a"
                onClicked: {
                    __root.showSettings()
                }
            }
        }
    }

    Item {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: rightMenuOptions.bottom
        anchors.bottom: parent.bottom

        Rectangle {
            id: active_button_bg
            height: (parent.height / menuItemsRepeater.count) + 3
            color: "#80ffffff"
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            Layout.columnSpan: 0
            Layout.rowSpan: 0
            border.width: 0
            y: menuItemsRepeater.count > 0 ? menuItemsRepeater.itemAt(
                                                 currentIndex).y : 0

            Behavior on y {
                NumberAnimation {
                    duration: 600
                    easing.type: Easing.OutBounce
                }
            }
        }
        ColumnLayout {
            id: menuColumn
            anchors.fill: parent
            anchors.topMargin: 6
            anchors.bottomMargin: 6
            anchors.leftMargin: 6
            spacing: 6

            Repeater {
                id: menuItemsRepeater
                model: PluginListModel {
                    plugins: PluginList
                    listType: "MainMenu"
                }

                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: Qt.darker("#673AB7", 1 + (index + 1) * 0.1)

                    Image {
                        id: button_image
                        width: 32
                        height: 32
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 6
                        fillMode: Image.PreserveAspectFit
                        source: icon
                        mipmap: true
                        visible: false
                    }
                    ColorOverlay {
                        color: HUDStyle.colors.text
                        anchors.fill: button_image
                        enabled: true
                        source: button_image
                    }

                    Text {
                        color: HUDStyle.colors.text
                        text: label
                        anchors.top: parent.top
                        anchors.topMargin: 0
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0
                        anchors.right: parent.right
                        anchors.rightMargin: 0
                        anchors.left: button_image.right
                        anchors.leftMargin: 6
                        wrapMode: Text.WordWrap
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pointSize: HUDStyle.sizes.menuText
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            __root.currentIndex = index
                        }
                    }
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:100}
}
##^##*/

