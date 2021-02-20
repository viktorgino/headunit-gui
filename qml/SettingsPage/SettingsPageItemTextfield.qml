import QtQuick 2.6
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0

import HUDTheme 1.0
SettingsPageItem {
    property alias value : textField.text
    id:__root
    itemData : {
        "label":"Textfield",
        "name": "textfield",
        "iconImage": "",
        "textType" : "string",
        "defaultValue" : "",
        "inputMask": "",
        "prefix" : "",
        "suffix" : ""
    }

    ThemeFormText {
        id: prefix
        text: itemData.prefix
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: textField.left
        anchors.rightMargin: 6
        font.pixelSize: 12
    }

    ThemeFormTextInput {
        id: textField
        anchors.right: suffix.left
        anchors.rightMargin: 8
        anchors.verticalCenter: parent.verticalCenter
        validator: switch(itemData.textType){
                   case "int":
                       return intValidator;
                   case "string":
                       return null;
                   case "double":
                       return doubleValidator;
                   case "regexp":
                       regexpValidator.regExp = new RegExp(itemData.regexp);
                       return regexpValidator;
                   }
        inputMask:itemData.inputMask
    }

    IntValidator {
        id:intValidator
    }

    DoubleValidator  {
        id:doubleValidator
    }

    RegExpValidator {
        id:regexpValidator
    }

    ThemeFormText {
        id: suffix
        width: parent.width * 0.05
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        text: itemData.suffix
        elide: Text.ElideLeft
        font.pixelSize: 12
    }
}
