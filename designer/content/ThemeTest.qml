import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    Button {
        id: button
        x: 8
        y: 8
        text: qsTr("Open Overlay")
        onClicked: {
            GUIEvents.emitNotificationReceived({
                                                   "image": "image://icons/alert",
                                                   "title": "Test notification",
                                                   "description": "This is a test notification"
                                               })
        }
    }
}
