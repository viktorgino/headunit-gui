import QtQuick 2.5
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.4
import "ClimateControl"

Item {
    id: dashLayout

    LinearGradient {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#36464e"
            }

            GradientStop {
                position: 1
                color: "#172027"
            }
        }
        end: Qt.point(200, 300)
        start: Qt.point(0, 0)
    }

    Image {
        id: image1
        fillMode: Image.PreserveAspectCrop
        anchors.fill: parent
        source: "qrc:/qml/images/ubuntu16_10_by_Khoir_Rudin.png"
    }

    Repeater{
        id: contents
        model:menuItems
        Loader {
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.right: rightMenu.left
            anchors.rightMargin: 0
            visible: false
            source: menuItems[index].source
            asynchronous: false
        }
    }

    RightMenu {
        id: rightMenu
        width: height/5
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        onItemChanged:{
            for(var i=0; i<contents.count;i++){
                contents.itemAt(i).visible = false
            }
            contents.itemAt(index).visible = true
        }
    }



    transitions: Transition {
        NumberAnimation { properties: "y,opacity"; duration: 250}
    }

    Connections {
        target: headunit
        onDeviceConnected: {
            notifications1.addNotification({
                                       image: notification.image,
                                       title: notification.title,
                                       text: notification.text})
        }
        onSetMenuItem:{
            rightMenu.menuItemClicked(index);
        }
    }
    Notifications {
        id: notifications1
        anchors.fill: parent
    }
}
