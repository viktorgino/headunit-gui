import QtQuick 2.11
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.4
import QtQml 2.0

import HUDTheme 1.0
import HUDPlugins 1.0

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

    BackgroundImage{
        anchors.fill: parent
    }

    Item {
        id: contents
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: bottomBar.top
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: rightMenu.left
        anchors.rightMargin: 0
        Repeater {
            id: contentsRepeater
            model:PluginListModel {
                plugins : HUDPlugins
                listType: "MainMenu"
            }

            Item {
                anchors.fill: parent
                Loader {
                    id:loader
                    asynchronous: false
                    anchors.fill: parent
                    source: plugin.qmlSource
                    active: plugin.loaded
                }
                Loader {
                    asynchronous: false
                    anchors.fill: parent
                    sourceComponent: loadingScreen
                    active: !plugin.loaded
                }
            }

        }

        Loader {
            id:settingsLoader
            asynchronous: false
            anchors.fill: parent
            source: "qrc:/qml/SettingsPage/SettingsPage.qml"
        }
    }

    Component {
        id:loadingScreen
        Item {
            anchors.fill: parent
            ThemeText {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Loading plugin...")
            }
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
            if(contentsRepeater.count > 0){
                for(var i=0; i<contentsRepeater.count;i++){
                    contentsRepeater.itemAt(i).visible = false
                }
                settingsLoader.visible = false;
                contentsRepeater.itemAt(index).visible = true
            }
        }
        onShowSettings: {
            for(var i=0; i<contentsRepeater.count;i++){
                contentsRepeater.itemAt(i).visible = false
            }
            settingsLoader.visible = true;
        }
    }

    transitions: Transition {
        NumberAnimation { properties: "y,opacity"; duration: 250}
    }

    Connections {
        target: GUIEvents
        ignoreUnknownSignals: true
        onNotificationReceived:{
            notificationsItem.addNotification(notification)
        }
        onOpenOverlay : {
            overlayLoader.setSource(source, properties);
            overlays.open()
        }
        onCloseOverlay : {
            overlays.close()
        }
    }

    Notifications {
        id: notificationsItem
        anchors.fill: parent
    }

    Item {
        id: bottomBar
        height: typeof source === "undefined"?parent.height * 0.1:0//HUDStyle.Sizes.bottomBarHeight
        anchors.left: parent.left
        anchors.right: rightMenu.left
        anchors.bottom: parent.bottom
        Loader {
            anchors.fill: parent
            source: "qrc:/HVAC/ClimateControl/HVACBottomBar.qml"
            asynchronous: false
        }
    }

    Timer {
        id:overlayCloseTimer
        interval: 5000; running: false; repeat: false
        onTriggered: overlays.close()
    }

    Item {
        id:overlays
        anchors.left: parent.left
        anchors.right: rightMenu.left
        anchors.top: parent.top
        anchors.bottom: bottomBar.top
        opacity: 0
        property var currentOverlay : ""
        function open () {
//            overlayCloseTimer.restart()
            opacity = 1;
        }
        function close () {
            opacity = 0;
            overlayLoader.sourceComponent = undefined;
        }

        Loader {
            id:overlayLoader
            anchors.fill: parent
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
