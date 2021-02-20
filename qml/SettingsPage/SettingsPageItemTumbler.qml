import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0

import HUDTheme 1.0

SettingsPageItem {
    id: __root
    property alias value : spinBox.value

    itemData : {
        "label":"Slider",
        "name": "slider",
        "default":18,
        "minimum": 5,
        "maximum": 30,
        "stepSize":1,
        "unit": "pixels",
        "prefix" : "",
        "suffix" : ""
    }

    ThemeFormText {
        id:prefixText
        width: 60
        height: parent.height/2
        text: itemData.prefix
        anchors.verticalCenter: parent.verticalCenter
        verticalAlignment: Text.AlignVCenter
        anchors.right: spinBox.left
        anchors.top: parent.top
        horizontalAlignment: Text.AlignHCenter
    }

    SpinBox {
        id: spinBox
        anchors.leftMargin: parent.leftPadding
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: suffixText.left
        wheelEnabled: true
        editable: true
        to: itemData.maximum
        from: itemData.minimum
        stepSize: itemData.stepSize
    }
    ThemeFormText {
        id:suffixText
        width: 60
        height: parent.height/2
        text: itemData.suffix
        anchors.verticalCenter: parent.verticalCenter
        verticalAlignment: Text.AlignVCenter
        anchors.right: parent.right
        anchors.top: parent.top
        horizontalAlignment: Text.AlignHCenter
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
