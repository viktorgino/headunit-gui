import QtQuick 2.5
import QtQuick.Window 2.3
import Qt.labs.settings 1.0
import "ClimateControl"
import "Radio"
Window {

    id: window
    visible: true
    title: qsTr("viktorgino's HeadUnit GUI")
    visibility: Window.AutomaticVisibility
    width: Screen.width
    height: Screen.height

    Settings {
        property alias x: window.x
        property alias y: window.y
        property alias width: window.width
        property alias height: window.height
        property alias visibility: window.visibility
        property alias screen: window.screen
    }

    FontLoader{id:ralewayRegular; source:"qrc:/qml/fonts/Raleway-Regular.ttf"}

    Rectangle {
        id: rectangle1
        color: "#000000"
        anchors.fill: parent
    }
    DashView{
        id: dashview
        anchors.fill: parent
    }
    Shortcut {
        sequence: "F11"
        onActivated: {
            if(window.visibility == Window.FullScreen)
                window.visibility = Window.Windowed
            else if(window.visibility == Window.Windowed)
                window.visibility = Window.Maximized
            else
                window.visibility = Window.FullScreen
        }
    }
}
