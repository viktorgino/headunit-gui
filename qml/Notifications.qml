import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    property int animationInterval : 250
    property int notificationInterval : 5000
    property int margin : 12

    ListModel {
        id: notifications
    }

    /*
     * Function that add a notification to the list of notifications
     * Usage example:
        addNotification({
                          image: "icons/android-call.png",
                          title: "Incoming call",
                          text: "Tap here to answer it"})
        addNotification({
                          image: "icons/android-call.png",
                          title: "Peter is calling",
                          text: "Tap here to answer it"})
        addNotification({
                          image: "icons/iphone.png",
                          title: "New Android device detected",
                          text: "Tap here to start Android Auto"})
     */
    function addNotification(notification){
        notifications.append({
                                 notificationImage:notification.image,
                                 notificationTitle:notification.title,
                                 notificationText:notification.text
                             });
    }
    Repeater {
        id: notificationsList
        anchors.fill: parent
        model: notifications
        Item {
            Timer {
                interval: 5000; running: true; repeat: false
                onTriggered: opacity=0
            }
            Timer {
                interval: animationInterval+notificationInterval; running: true; repeat: false
                onTriggered: notifications.remove(index,1)
            }
            y: parent.height - ((notificationsList.count-index) * height) - ((notificationsList.count-index) * margin)
            width: 300
            height: 75
            opacity: 1
            anchors.left: parent.left
            anchors.leftMargin: margin

            Rectangle {
                color: "#ffffff"
                opacity: 0.5
                anchors.fill: parent
            }

            Item {
                width: height
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0

                Rectangle {
                    color: "#80ffffff"
                    radius: height / 2
                    anchors.rightMargin: 12
                    anchors.leftMargin: 12
                    anchors.bottomMargin: 12
                    anchors.topMargin: 12
                    anchors.fill: parent

                    Image {
                        anchors.rightMargin: 10
                        anchors.leftMargin: 10
                        anchors.bottomMargin: 10
                        anchors.topMargin: 10
                        fillMode: Image.PreserveAspectFit
                        anchors.fill: parent
                        source: notificationImage
                    }
                }
            }

            Item {
                anchors.leftMargin: height
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0

                Text {
                    height: parent.height / 2
                    color: "#ffffff"
                    text: notificationTitle
                    wrapMode: Text.WordWrap
                    verticalAlignment: Text.AlignBottom
                    horizontalAlignment: Text.AlignLeft
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    font.pixelSize: 16
                }

                Text {
                    height: parent.height / 2
                    color: "#ffffff"
                    text: notificationText
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignLeft
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    font.pixelSize: 12
                    anchors.right: parent.right
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                }
            }
            Behavior on y{

                NumberAnimation {
                    duration: 250
                }
            }
            Behavior on opacity{

                NumberAnimation {
                    duration: 250
                }
            }
        }
    }
    transitions: Transition {
        NumberAnimation { properties: "y,opacity"; duration: 250}
    }
}
