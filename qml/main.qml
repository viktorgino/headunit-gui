import QtQuick 2.5
import QtQuick.Window 2.2
import Qt.labs.settings 1.0
import "ClimateControl"
import "Radio"
Window {

    id: window
    visible: true
    width: 800
    height: 480
    title: qsTr("viktorgino's HeadUnit GUI")

    Settings {
        property alias x: window.x
        property alias y: window.y
        property alias width: window.width
        property alias height: window.height
        property alias visibility: window.visibility
    }

    FontLoader{id:ralewayRegular; source:"qrc:/qml/fonts/Raleway-Regular.ttf"}

    Rectangle {
        id: rectangle1
        color: "#000000"
        anchors.fill: parent
    }
    DashView{
        anchors.fill: parent
    }

}
