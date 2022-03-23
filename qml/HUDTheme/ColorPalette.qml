import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import QtGraphicalEffects 1.0

Item{
    id: __root
    property int paletteSize : 12
    property color color: "#0000ff"
    signal rejected()
    signal accepted(var color)
    property alias gridLayout1Width: gridLayout1.width

    Item {
        id: palette
        width: parent.width*0.5
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0

        Item {
            id: swatchWrapper
            anchors.bottom: slider.top
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottomMargin: 0

            Item {
                id:swatch
                width: parent.width > parent.height?parent.height:parent.width
                height: width
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                GridLayout {
                    id: gridLayout
                    anchors.fill: parent
                    rows: 12
                    columnSpacing: 0
                    rowSpacing: 0
                    columns: __root.paletteSize

                    Repeater {
                        id: gridView
                        model: __root.paletteSize * __root.paletteSize
                        delegate: Rectangle {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            property int row: Math.floor(index/__root.paletteSize)
                            property int column: index % __root.paletteSize
                            property double saturation: 1 - (1 / (__root.paletteSize - 1) * column)
                            property double brightness: 1 - (1 / (__root.paletteSize - 1) * row)
                            color: Qt.hsva(__root.color.hslHue, saturation, brightness, 1)
                        }
                    }
                }

                Rectangle{
                    id:cross
                    width: 20
                    height: 20
                    radius: 10
                    border.width: 1
                    border.color: "black"
                    color: "transparent"
                    Rectangle{
                        width: 18
                        height: 18
                        radius: 9
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        border.width: 1
                        border.color: "#ffffff"
                        color: "transparent"
                    }
                }

                MouseArea{
                    function moveCrossToMouse(){
                        var Xmin = cross.width/2;
                        var Xmax = gridLayout.width - cross.width/2;

                        var Ymin = cross.height/2;
                        var Ymax = gridLayout.height - cross.height/2;

                        var crossX =  0;
                        var crossY =  0;

                        if(mouseX < Xmin){
                            crossX = Xmin;
                        } else if(mouseX > Xmax){
                            crossX = Xmax;
                        } else {
                            crossX = mouseX;
                        }

                        if(mouseY < Ymin){
                            crossY = Ymin;
                        } else if(mouseY > Ymax){
                            crossY = Ymax;
                        } else {
                            crossY = mouseY;
                        }

                        cross.x = crossX - cross.width / 2;
                        cross.y = crossY - cross.height / 2;

                        var row = Math.floor(crossY/gridLayout.height*paletteSize );
                        var column = Math.floor(crossX/gridLayout.width*paletteSize );

                        var saturation = 1 - (1 / (paletteSize - 1) * column);
                        var lightness = 1 - (1 / (paletteSize - 1) * row);
                        __root.color = Qt.hsva(slider.value, saturation, lightness, 1);
                    }
                    anchors.fill: gridLayout
                    onPositionChanged: {
                        moveCrossToMouse()
                    }
                    onClicked: {
                        moveCrossToMouse()
                    }
                }
            }
        }


        Slider {
            height: 50
            id: slider
            stepSize: 1/360
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            from: 0
            to: 1

            value: __root.color.hslHue

            Binding {
                target:__root
                property: "color.hslHue"
                value: slider.value
            }

            background: Item {
                id: item1
                anchors.fill: parent
                Rectangle {
                    width: 25
                    color: Qt.rgba(1, 0, 0, 1)
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0

                }

                LinearGradient {
                    anchors.rightMargin: 25
                    anchors.leftMargin: 25
                    anchors.fill: parent
                    start: Qt.point(0, 0)
                    end: Qt.point(slider.availableWidth, 0)
                    gradient: Gradient {
                        GradientStop {
                            position: 0/6
                            color: Qt.hsla(0, 1, 1/2, 1)
                        }
                        GradientStop {
                            position: 1/6
                            color: Qt.hsla(1/6, 1, 1/2, 1)
                        }
                        GradientStop {
                            position: 2/6
                            color: Qt.hsla(2/6, 1, 1/2, 1)
                        }
                        GradientStop {
                            position: 3/6
                            color: Qt.hsla(3/6, 1, 1/2, 1)
                        }
                        GradientStop {
                            position: 4/6
                            color: Qt.hsla(4/6, 1, 1/2, 1)
                        }
                        GradientStop {
                            position: 5/6
                            color: Qt.hsla(5/6, 1, 1/2, 1)
                        }
                        GradientStop {
                            position: 6/6
                            color: Qt.hsla(1, 1, 1/2, 1)
                        }
                    }
                }
                Rectangle {
                    width: 25
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    color: Qt.rgba(1, 0, 0, 1)
                }
            }
            handle: Rectangle {
                x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
                y: slider.topPadding + slider.availableHeight / 2 - height / 2
                color: Qt.hsva(__root.color.hslHue, 1, 1, 1)
                radius: 25
                border.width: 10
                implicitWidth: 50
                implicitHeight: 50
                border.color: "#bdbebf"
            }
        }

    }

    ColumnLayout {
        anchors.left: palette.right
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: false

            ThemeFormText {
                text: qsTr("Color")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
            }

            Rectangle {
                id:colorRect
                height: 40
                Layout.fillHeight: true
                Layout.fillWidth: true
                color:__root.color
                Layout.preferredWidth: __root.width/8
            }
        }


        Item {
            id: rowLayout
            Layout.fillHeight: true
            Layout.fillWidth: true


            GridLayout {
                id: gridLayout1
                width: parent.width/2
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                Layout.preferredWidth: parent.width/2
                columns: 2

                ThemeFormText {
                    text: qsTr("Brightness:")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }


                ThemeFormText {
                    text: Math.round(__root.color.hslLightness  * 100)
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }



                ThemeFormText {
                    text: qsTr("Saturation:")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                ThemeFormText {
                    text: Math.round(__root.color.hslSaturation * 100)
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }


                ThemeFormText {
                    text: qsTr("Hue:")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }


                ThemeFormText {
                    text: Math.round(__root.color.hslHue * 360)
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }



            }
            GridLayout {
                width: parent.width/2
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0
                Layout.preferredWidth: parent.width/2
                columns: 2

                ThemeFormText {
                    text: qsTr("B:")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }


                ThemeFormText {
                    text: Math.round(__root.color.b * 255)
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }

                ThemeFormText {
                    text: qsTr("G:")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                ThemeFormText {
                    text: Math.round(__root.color.g * 255)
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }

                ThemeFormText {
                    text: qsTr("R:")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                ThemeFormText {
                    text: Math.round(__root.color.r * 255)
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }
            }

        }

        Item {
            id: item2
            height: 30
            Layout.fillHeight: false
            Layout.fillWidth: true


            ThemeFormText {
                text: qsTr("#")
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: colorString.left
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }
            ThemeFormText{
                id: colorString
                text: String(__root.color).slice(1,7)
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignLeft
            }

        }

        Button {
            text: qsTr("OK")
            Layout.fillWidth: true
            Layout.columnSpan: 2
            onClicked: __root.accepted(__root.color)
        }


        Button {
            text: qsTr("Cancel")
            Layout.fillWidth: true
            Layout.columnSpan: 2
            onClicked: __root.rejected()
        }







    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:400;width:800}D{i:2}
}
##^##*/
