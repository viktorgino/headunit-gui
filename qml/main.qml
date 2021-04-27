import QtQuick 2.5
import QtQuick.Window 2.2
import Qt.labs.settings 1.0

Window {

    id: window
    visible: true
    title: qsTr("viktorgino's HeadUnit")
    visibility: Window.Maximized
    width: 800
    height: 480

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
