import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.4

import HUDTheme 1.0
import HUDPlugins 1.0

Item {
    id: dashLayout
    anchors.fill: parent
    state: rightMenu.extendedMenu ? "menuOpen" : ""

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

    BackgroundImage {
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
            model: PluginListModel {
                plugins: PluginList
                listType: "MainMenu"
            }

            Item {
                anchors.fill: parent
                Loader {
                    id: loader
                    asynchronous: false
                    anchors.fill: parent
                    active: pluginLoaded
                    visible: pluginLoaded && rightMenu.currentIndex === index
                             && !settingsLoader.active
                }
                Loader {
                    asynchronous: false
                    anchors.fill: parent
                    sourceComponent: loadingScreen
                    active: !pluginLoaded
                    visible: !pluginLoaded && rightMenu.currentIndex === index
                    onActiveChanged: {
                        if (pluginLoaded)
                            loader.setSource(qmlSource, {
                                                 "pluginContext": contextProperty,
                                                 "pluginSettings": settings
                                             })
                        else
                            loader.setSource("")
                    }
                }
            }
        }

        Loader {
            id: settingsLoader
            asynchronous: false
            anchors.fill: parent
            active: false
            function loadSettings() {
                active = true
                visible = true
                setSource("HUDSettingsPage/SettingsPage.qml")
            }
            function unloadSettings() {
                active = false
                visible = false
                setSource("")
            }
        }
    }

    Component {
        id: loadingScreen
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
        x: parent.width - (32 + 12 + 5)
        width: parent.width * 0.15
        anchors.top: parent.top
        anchors.bottom: bottomBar.top
        onCurrentIndexChanged: {
            settingsLoader.unloadSettings()
        }
        onShowSettings: {
            settingsLoader.loadSettings()
        }

        transitions: Transition {
            NumberAnimation {
                properties: "x"
                easing.type: Easing.InOutQuad
            }
        }
    }

    Connections {
        target: GUIEvents
        ignoreUnknownSignals: true
        property int prevVisiblePageIndex: 0

        onNotificationReceived: {
            notificationsItem.addNotification(notification)
        }
        onOpenOverlay: {
            properties.pluginContext = contextProperty
            properties.pluginSettings = settings
            overlayLoader.setSource(source, properties)
            overlays.open()
        }
        onCloseOverlay: {
            overlays.close()
        }

        //Go to the page next to the currently visible page
        onChangePageNext: {
            if(settingsLoader.visible) {
                bottomMenu.currentIndex = 0;
            } else if (bottomMenu.currentIndex === (contentsRepeater.count - 1)) {
                settingsLoader.loadSettings();
            } else {
                if(bottomMenu.currentIndex >= (contentsRepeater.count - 1)) {
                    bottomMenu.currentIndex = contentsRepeater.count - 1;
                } else {
                    bottomMenu.currentIndex++;
                }
            }
        }

        //Go to the page previous to the currently visible page
        onChangePagePrev: {
             if(settingsLoader.visible) {
                bottomMenu.currentIndex = contentsRepeater.count - 1;
            } else if (bottomMenu.currentIndex === 0) {
                settingsLoader.loadSettings();
            } else {
                if(bottomMenu.currentIndex <= 0) {
                    bottomMenu.currentIndex = 0;
                } else {
                    bottomMenu.currentIndex--;
                }
            }
        }
        //Jump to a particular page index
        onChangePageIndex: {
            if(settingsLoader.visible) {
                prevVisiblePageIndex = -1;
            } else {
                prevVisiblePageIndex = bottomMenu.currentIndex;
            }
            bottomMenu.currentIndex = index;
        }
        //Change back to the page that was visible before onChangePageIndex was called
        onChangePagePrevIndex: {
            if(prevVisiblePageIndex === -1) {
                settingsLoader.loadSettings();
            } else {
                bottomMenu.currentIndex = prevVisiblePageIndex;
            }
        }
    }

    Notifications {
        id: notificationsItem
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: bottomBar.top
    }

    Timer {
        id: overlayCloseTimer
        interval: 5000
        running: false
        repeat: false
        onTriggered: overlays.close()
    }

    Item {
        id: overlays
        anchors.left: parent.left
        anchors.right: rightMenu.left
        anchors.top: parent.top
        anchors.bottom: bottomBar.top
        opacity: 0
        property var currentOverlay: ""
        function open() {
            //            overlayCloseTimer.restart()
            opacity = 1
        }
        function close() {
            opacity = 0
            overlayLoader.sourceComponent = undefined
        }

        Loader {
            id: overlayLoader
            anchors.fill: parent
        }
    }
    BottomBar {
        id: bottomBar
        height: parent.height * 0.1 //HUDStyle.sizes.bottomBarHeight
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }

    Connections {
        target: overlayLoader.item
        ignoreUnknownSignals: true
        onClose: {
            overlays.close()
        }
    }

    states: [
        State {
            name: "menuOpen"

            PropertyChanges {
                target: rightMenu
                x: parent.width - width
                anchors.rightMargin: 0
            }
        }
    ]

    transitions: Transition {
        NumberAnimation {
            properties: "y,opacity,x"
            duration: 250
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorColor:"#4c4e50";height:480;width:640}D{i:5;invisible:true}
}
##^##*/

