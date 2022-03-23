import QtQuick 2.6
import QtQuick.Layouts 1.0
import Qt.labs.settings 1.0
import QtGraphicalEffects 1.0

import HUDPlugins 1.0

Item {
    property int menuItemIndex: 0
    id: __root
    signal itemChanged(int index);
    signal showSettings();

    function menuItemClicked (index){
        menuItemIndex = index
        active_button_bg.y = menuItemsRepeater.itemAt(index).y;
        __root.itemChanged(index);
    }

    Component.onCompleted: {
        itemChanged(menuItemIndex);
    }

    Settings {
        property alias menuItemIndex: __root.menuItemIndex
    }

    Rectangle {
        color: "#212121"
        anchors.fill: parent
        opacity: 0.4
    }

    Rectangle {
        id: active_button_bg
        height: (parent.height/menuItemsRepeater.count)+5
        color: "#80ffffff"
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        Layout.columnSpan: 0
        Layout.rowSpan: 0
        border.width: 0
        y:menuItemsRepeater.count > 0 ?menuItemsRepeater.itemAt(menuItemIndex).y:0

        Behavior on y {

            NumberAnimation {
                //This specifies how long the animation takes
                duration: 600
                //This selects an easing curve to interpolate with, the default is Easing.Linear
                easing.type: Easing.OutBounce
            }
        }

    }

    ColumnLayout {
        id:menuColumn
        anchors.topMargin: 5
        spacing: 0
        anchors.fill: parent

        Repeater {
            id:menuItemsRepeater
            model:PluginListModel {
                plugins : HUDPlugins
                listType: "MainMenu"
            }

            Item {
                Layout.fillHeight: true
                Layout.columnSpan: 1
                Layout.fillWidth: true
                Rectangle {
                    anchors.leftMargin: 5
                    anchors.rightMargin: 5
                    anchors.bottomMargin: 5
                    anchors.fill: parent
                    color: menu.color

                    Image {
                        id: button_image
                        width: HUDStyle.sizes.menuIcon
                        height: HUDStyle.sizes.menuIcon
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 0
                        fillMode: Image.PreserveAspectFit
                        source: icon
                        mipmap:true
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
                        anchors.leftMargin: 0
                        wrapMode: Text.WordWrap
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pointSize: HUDStyle.sizes.menuText
                    }

                    MouseArea {
                        id: mouseArea1
                        anchors.fill: parent
                        onClicked: menuItemClicked(index)
                    }
                }
            }
        }
     }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:100}D{i:1}D{i:2}D{i:3}D{i:9}D{i:10}D{i:11}D{i:12}
D{i:8}D{i:7}D{i:5}D{i:4}
}
##^##*/
