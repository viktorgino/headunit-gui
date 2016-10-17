import QtQuick 2.5
import QtQuick.Window 2.2
import "ClimateControl"
import "Radio"
Window {
    visible: true
    width: 800
    height: 480
    title: qsTr("Hello World")

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
