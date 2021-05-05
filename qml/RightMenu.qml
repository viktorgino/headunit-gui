import QtQuick 2.6
import QtQuick.Layouts 1.0
import Qt.labs.settings 1.0
import QtGraphicalEffects 1.0

Item {
    property int menuItemIndex: 0
    id: __root
    signal itemChanged(int index);

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
        height: (parent.height/menuItems.length)+5
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
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.bottomMargin: 5
        anchors.topMargin: 5
        spacing: 5
        anchors.fill: parent

        Repeater{
            id:menuItemsRepeater
            model:menuItems.length
            Rectangle {
                color:menuItems[index].color
                Layout.fillHeight: true
                Layout.columnSpan: 1
                Layout.fillWidth: true

                Image {
                    id: button_image
                    width: HUDStyle.Sizes.menuIcon
                    height: HUDStyle.Sizes.menuIcon
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    fillMode: Image.PreserveAspectFit
                    source: menuItems[index].image
                    mipmap:true
                    visible: false
                }
                ColorOverlay {
                    id: button_image_color
                    color: HUDStyle.Colors.text
                    anchors.fill: button_image
                    enabled: true
                    source: button_image
                }

                Text {
                    id: text1
                    color: HUDStyle.Colors.text
                    text: menuItems[index].text;
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
                    font.pointSize: HUDStyle.Sizes.menuText
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
