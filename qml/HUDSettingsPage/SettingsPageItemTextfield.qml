import QtQuick 2.6
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0

import HUDTheme 1.0
SettingsPageItem {
    id:__root

    property alias value : textField.text

//    itemData : {
//        "label":"Textfield",
//        "name": "textfield",
//        "iconImage": "",
//        "textType" : "string",
//        "defaultValue" : "",
//        "inputMask": "",
//        "prefix" : "",
//        "suffix" : ""
//    }
    property string textType : "string"
    property string regexp : ""
    property alias inputMask : textField.inputMask
    property alias prefix : prefix.text
    property alias suffix : suffix.text

    ThemeFormText {
        id: prefix
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: textField.left
        anchors.rightMargin: 6
    }

    ThemeFormTextInput {
        id: textField
        anchors.right: suffix.left
        anchors.rightMargin: 8
        anchors.verticalCenter: parent.verticalCenter
        validator: switch(__root.textType){
                   case "int":
                       return intValidator;
                   case "string":
                       return null;
                   case "double":
                       return doubleValidator;
                   case "regexp":
                       regexpValidator.regExp = new RegExp(__root.regexp);
                       return regexpValidator;
                   }
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
        elide: Text.ElideLeft
    }
}
