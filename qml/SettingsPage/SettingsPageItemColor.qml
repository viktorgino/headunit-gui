import QtQuick 2.7
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

//import HUDStyle 1.0
import HUDTheme 1.0

SettingsPageItem {
    id:__root
    property alias color: colorRect.color
    property alias value : colorInput.text
    itemData: {
        "label":"Color",
        "name": "color",
        "description":"",
        "defaultValue":"",
        "initColor": "#000000"
    }

//    Component.onCompleted: {
//        colorInput.text = itemData.initColor
//    }
    onItemDataChanged: {
        colorInput.text = itemData.initColor
    }

    ThemeFormTextInput {
        id: colorInput
        width: 80
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: colorRect.left
        anchors.rightMargin: 8
        onTextChanged: {
            if(text.charAt(0) != "#"){
                text = "#" + text
            } else if(text.charAt(1) == "#") {
                text = text.slice(1,8);
            } else {
                colorRect.color = text
                __root.value = text
            }
        }
        validator: RegExpValidator { regExp: /[#?]{0,2}([0-9A-Fa-f]{8}|[0-9A-Fa-f]{6})/ }
    }

    Rectangle {
        id: colorRect
        width: 50
        height: 50
        color: colorInput.text
        anchors.rightMargin: parent.width * 0.05 + 8
        border.color: "#000000"
        border.width: 1
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        MouseArea{
            anchors.fill: parent
            onClicked: {
                popup.open()
            }
        }
        Popup {
            id: popup
            implicitWidth: window.width * 0.6
            implicitHeight: window.height * 0.6
            leftMargin: window.width * 0.2
            rightMargin: window.width * 0.2
            topMargin: window.height * 0.2
            bottomMargin: window.height * 0.2
            modal: true
            focus: true
            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

            ColorPalette{
                width: popup.width
                height: popup.height
                anchors.fill: parent
                paletteSize:16
                color:colorRect.color
                onRejected: popup.close()
                onAccepted: {
                    colorInput.text = color
                    onRejected: popup.close()
                }
            }
        }
    }
}
