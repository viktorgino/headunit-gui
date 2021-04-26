import QtQuick 2.11
import QtQuick.Controls 2.4

TextField {
    id:control
    font.family: HUDStyle.themeSettings.font
    font.pixelSize: HUDStyle.Sizes.formText
    color: HUDStyle.Colors.formText
    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 40
        color: control.enabled ? "transparent" : HUDStyle.Colors.formBox
    }
}
