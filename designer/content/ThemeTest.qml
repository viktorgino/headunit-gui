import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    Button {
        id: button
        x: 8
        y: 8
        text: qsTr("Send Notification")
        onClicked: {
            GUIEvents.emitNotificationReceived({
                                                   "image": "image://icons/alert",
                                                   "title": "Test notification",
                                                   "description": "This is a test notification"
                                               })
        }
    }
    Button {
        id: button2
        x: 8
        y: 54
        text: qsTr("Open Bottom Bar Items")
        onClicked: {
            BottomBarModel.editing = true
            GUIEvents.emitOpenOverlay("BottomBarEditPanel.qml", {})
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:600}
}
##^##*/
