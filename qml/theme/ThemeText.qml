import QtQuick 2.6

Text{
    property bool subtext: false
    color: !subtext?HUDStyle.Colors.text:HUDStyle.Colors.subText
    font.family: HUDStyle.themeSettings.font
    font.pixelSize: !subtext?HUDStyle.Sizes.text:HUDStyle.Sizes.subText
}
