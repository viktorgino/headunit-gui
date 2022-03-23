import QtQuick 2.11
import QtQuick.Controls 2.4

TextField {
    id:control
    font.family: HUDStyle.themeSettings.font
    font.pointSize: HUDStyle.sizes.formText
    color: HUDStyle.colors.formText
    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 40
        color: HUDStyle.colors.formBackground
        border.color: HUDStyle.colors.formText
        border.width: 1
    }
}
