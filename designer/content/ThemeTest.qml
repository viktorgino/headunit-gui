import QtQuick 2.15
import QtQuick.Controls 2.15

import HUDPlugins 1.0

Item {
    id: root
    Button {
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
        x: 8
        y: 54
        text: qsTr("Open Bottom Bar Items")
        onClicked: {
            BottomBarModel.editing = true

            //            GUIEvents.emitOpenOverlay({}, {}, "BottomBarEditPanel.qml", {source: "../../qml/HUDTheme/SliderVolume.qml"})
            GUIEvents.openOverlay({}, null, "BottomBarEditPanel.qml", {})
        }
    }
    Button {
        x: 8
        y: 100
        text: qsTr("Level Slider")
        onClicked: {
            GUIEvents.emitOpenOverlay({}, {},
                                      "../designer/content/Overlay.qml", {
                                          "source": "../../qml/HUDTheme/SliderVolume.qml"
                                      })
        }
    }
    Button {
        x: 8
        y: 146
        text: qsTr("Center Slider")
        onClicked: {
            GUIEvents.emitOpenOverlay({}, {},
                                      "../designer/content/Overlay.qml", {
                                          "source": "../../qml/HUDTheme/SliderCenter.qml"
                                      })
        }
    }
    Button {
        x: 8
        y: 192
        text: qsTr("File Browser")
        onClicked: {
            GUIEvents.emitOpenOverlay({}, {},
                                      "../designer/content/Overlay.qml", {
                                          "source": "../../qml/HUDTheme/FileBrowser.qml"
                                      })
        }
    }
    Button {
        x: 8
        y: 238
        text: qsTr("Folder Browser")
        onClicked: {
            GUIEvents.emitOpenOverlay({}, {},
                                      "../designer/content/Overlay.qml", {
                                          "source": "../../qml/HUDTheme/FileBrowser.qml",
                                          "properties": {
                                              "showFiles": false,
                                              "folderSelectable": true
                                          }
                                      })
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:600}
}
##^##*/

