import QtQuick 2.5
import QtQuick.Window 2.2
import Qt.labs.settings 1.0
import QtQuick.Window 2.2
import "ClimateControl"
import "Radio"
Window {

    id: window
    visible: true
    title: qsTr("viktorgino's HeadUnit GUI")
    visibility: Window.AutomaticVisibility
    width: Screen.width
    height: Screen.height

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
