import QtQuick 2.6

Text{
    property int level: 1
    color: HUDStyle.Colors["headingText"+level]
    font.family: HUDStyle.themeSettings.font
    font.pointSize: HUDStyle.Sizes["headingText"+level]
}


