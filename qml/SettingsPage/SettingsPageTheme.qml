import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import QtGraphicalEffects 1.0

import HUDTheme 1.0

Item {
    id: __root
    function backAction(){
        if(settingStack.depth > 1){
            settingStack.pop();
            return true;
        }
        return false;
    }
    signal pop()
    function back() {
        if(settingStack.depth > 1){
            settingStack.pop()
        } else {
            pop()
        }
    }

    StackView {
        id: settingStack
        width: parent.width/2
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.top: parent.top
        initialItem: itemList
        clip:true
    }
    Component{
        id:itemList
        SettingsPageItemList{
            settings: HUDStyle
            model: HUDStyleSettings
            enableIcons : false
            autoSave: true
            onPush: {
                properties.settings = settings[properties.name]
                properties.enableIcons = false
                properties.autoSave = true

                settingStack.push(itemList, properties)
            }
            onPop: {
            }
        }
    }

    Item {
        id: item3
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: settingStack.right
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        Item {
            id: item2
            height: parent.height / 2
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0

            BackgroundImage{
                anchors.fill: parent
            }

            Rectangle {
                id: rectangle
                height: parent.height * 0.2
                color: HUDStyle.Colors.box
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0

                RowLayout {
                    id: rowLayout
                    anchors.fill: parent

                    ThemeText {
                        text: qsTr("Normal")
                        Layout.fillHeight: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        Layout.fillWidth: true
                    }

                    ImageButton{
                        width: 40
                        height: 40
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        imageSource:"qrc:/qml/icons/heart.png"
                        text:""
                        color: HUDStyle.Colors.icon
                    }


                    ThemeText {
                        text: qsTr("Active")
                        Layout.fillHeight: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        Layout.fillWidth: true
                    }

                    ImageButton{
                        width: 40
                        height: 40
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        imageSource:"qrc:/qml/icons/heart.png"
                        text:""
                        color: HUDStyle.Colors.iconActive
                    }


                }
            }

            RowLayout {
                anchors.bottom: rectangle.top
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottomMargin: 0

                ColumnLayout {
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    ThemeHeaderText {
                        text: qsTr("Heading Level 5")
                        Layout.columnSpan: 2
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        level:5
                    }

                    ThemeHeaderText {
                        text: qsTr("Heading Level 4")
                        Layout.columnSpan: 2
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        level:4
                    }

                    ThemeHeaderText {
                        text: qsTr("Heading Level 3")
                        Layout.columnSpan: 2
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        level:3
                    }

                    ThemeHeaderText {
                        text: qsTr("Heading Level 2")
                        Layout.columnSpan: 2
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        level:2
                    }

                    ThemeHeaderText {
                        text: qsTr("Heading Level 1")
                        Layout.columnSpan: 2
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        level:1
                    }




                }

                ColumnLayout {
                    id: columnLayout
                    Layout.fillHeight: true
                    Layout.fillWidth: true


                    ThemeText {
                        id: text3
                        text: qsTr("Normal Text")
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }

                    ThemeText {
                        id: text4
                        text: qsTr("Sub Text")
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        subtext: true
                    }
                }
            }
        }

        Item {
            id: item4
            height: parent.height /2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            clip:true

            RectangularGlow {
                id: effect
                anchors.fill: rectangle1
                glowRadius: 20
                spread: -0.1
                color: "#000000"
                cornerRadius: 0
            }

            Rectangle {
                id: rectangle1
                height: parent.height * 0.3
                color: HUDStyle.Colors.formBox
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0
                Image {
                    id: settingsIcon
                    width: height
                    height: parent.height/2
                    anchors.leftMargin: width/2
                    anchors.verticalCenter: parent.verticalCenter
                    fillMode: Image.PreserveAspectFit
                    anchors.left: parent.left
                    source: "qrc:/qml/icons/android-settings.png"
                    mipmap:true

                    ColorOverlay {
                        color: HUDStyle.Colors.icon
                        anchors.fill: parent
                        enabled: true
                        source: parent
                    }
                }

                ThemeHeaderText {
                    id: text5
                    text: qsTr("Header Text")
                    anchors.verticalCenterOffset: height/-2
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: settingsIcon.right
                    anchors.leftMargin: 16
                }

                ThemeHeaderText {
                    id: text6
                    text: qsTr("Header Sub Text")
                    anchors.verticalCenterOffset: height/2
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: text5.left
                    anchors.leftMargin: 0
                    level: 2
                }
            }


            ListView {
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: rectangle1.bottom
                anchors.topMargin: 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                clip:true
                model: 20
                delegate: SettingsPageItem {
                    label : "Item " + index + " title"
                    description : "Item " + index + " subtitle"
                }
            }
        }

    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:50;anchors_x:0;anchors_y:"-240"}D{i:63;anchors_height:100;anchors_width:100}
D{i:62;anchors_height:100;anchors_width:100}
}
 ##^##*/
