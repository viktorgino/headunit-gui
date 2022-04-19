import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0

import HUDTheme 1.0

SettingsPageItem {
    id: __root
    property alias value : slider.value

    //Properties
    property alias minimum : slider.from
    property alias maximum : slider.to
    property alias stepSize : slider.stepSize
    property string prefix : ""
    property string suffix : ""

    ThemeFormText {
        id:text2
        width: 60
        height: parent.height/2
        text: __root.prefix + " " + slider.value + " " + __root.suffix
        anchors.verticalCenter: parent.verticalCenter
        verticalAlignment: Text.AlignVCenter
        anchors.right: parent.right
        anchors.top: parent.top
    }

    ThemeSlider{
        id:slider
        width: parent.width/2
        anchors.rightMargin: 8
        anchors.leftMargin: parent.width / 2
        anchors.verticalCenter: parent.verticalCenter
        padding: 7
        anchors.left: parent.left
        anchors.right: text2.left
        wheelEnabled: true
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
