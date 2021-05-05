import QtQuick 2.6

Text{
    property bool subtext: false
    color: !subtext?HUDStyle.Colors.formText:HUDStyle.Colors.formSubText
    font.family: HUDStyle.themeSettings.font
    font.pointSize: !subtext?HUDStyle.Sizes.formText:HUDStyle.Sizes.formSubText
}
