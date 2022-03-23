import QtQuick 2.6

Text{
    property bool subtext: false
    color: !subtext?HUDStyle.colors.text:HUDStyle.colors.subText
    font.family: HUDStyle.themeSettings.font
    font.pointSize : !subtext?HUDStyle.sizes.text:HUDStyle.sizes.subText
}
