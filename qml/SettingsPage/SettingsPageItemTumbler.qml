import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0

import HUDTheme 1.0

SettingsPageItem {
    id: __root
    property alias value : spinBox.value

//    itemData : {
//        "label":"Tumbler",
//        "name": "tumbler",
//        "default":18,
//        "minimum": 5,
//        "maximum": 30,
//        "stepSize":1,
//        "prefix" : "",
//        "suffix" : ""
//    }

    property alias minimum : spinBox.from
    property alias maximum : spinBox.to
    property alias stepSize : spinBox.stepSize
    property alias prefix : prefixText.text
    property alias suffix : suffixText.text

    ThemeFormText {
        id:prefixText
        width: 60
        height: parent.height/2
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
        contentItem: ThemeFormTextInput {
            z: 2
            implicitHeight: 40
            implicitWidth: 80
            text: spinBox.textFromValue(spinBox.value, spinBox.locale)
            anchors.verticalCenter: parent.verticalCenter

            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter

            readOnly: !spinBox.editable
            validator: spinBox.validator
            inputMethodHints: Qt.ImhFormattedNumbersOnly
        }
        up.indicator: Rectangle {
            x: spinBox.mirrored ? 0 : parent.width - width
            implicitWidth: 40
            implicitHeight: 40
            color: spinBox.up.pressed ? "#00000000" : HUDStyle.Colors.formBackground
            border.color: HUDStyle.Colors.formText
            border.width: 1
            anchors.verticalCenter: parent.verticalCenter
            ThemeText {
                text: "+"
                font.pointSize: spinBox.font.pointSize * 2
                anchors.fill: parent
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        down.indicator: Rectangle {
            id: rectangle
            x: spinBox.mirrored ? parent.width - width : 0
            implicitWidth: 40
            implicitHeight: 40
            color: spinBox.down.pressed ? "#00000000" : HUDStyle.Colors.formBackground
            border.color: HUDStyle.Colors.formText
            border.width: 1
            anchors.verticalCenter: parent.verticalCenter
            ThemeText {
                text: "-"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                font.pointSize: spinBox.font.pointSize * 2
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
        background: Item {

        }
    }
    ThemeFormText {
        id:suffixText
        width: 60
        height: parent.height/2
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
