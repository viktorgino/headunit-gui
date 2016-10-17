import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0

Item{
    property bool slider_enabled: true
    Layout.fillHeight: true
    Layout.fillWidth: true
    RowLayout {
        anchors.fill: parent
        implicitHeight: 80
        implicitWidth: 200
        Item {
            id: left_icon
            Layout.fillHeight: true
            Layout.fillWidth: true

            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/qml/icons/svg/ac.svg"
                width: 40
                height: 40
            }
        }

        Repeater{
            model: fanslider.maximumValue-1
            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Rectangle {
                    width: 15
                    height: 15
                    color: "#ffffff"
                    radius: width
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        Item {
            id: right_icon
            Layout.fillHeight: true
            Layout.fillWidth: true

            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/qml/icons/svg/ac.svg"
                width: 80
                height: 80
                visible: (fanslider.value != fanslider.maximumValue)
            }
        }
    }

    Slider {
        id:fanslider
        value: 0
        anchors.rightMargin: left_icon.width/2-40
        anchors.bottomMargin: 0
        anchors.topMargin: 0
        anchors.leftMargin: right_icon.width/2-40
        anchors.fill: parent
        orientation: Qt.Horizontal
        maximumValue: 6
        stepSize: 1
        enabled: slider_enabled
        style: SliderStyle {
            handle: Rectangle {
                radius: 40
                width: 80
                height: 80
                color: "#4cffffff"

                Rectangle {
                    color: "#ffffff"
                    anchors.rightMargin: parent.width * 0.1
                    anchors.leftMargin: parent.width * 0.1
                    anchors.bottomMargin: parent.height * 0.1
                    anchors.topMargin: parent.height * 0.1
                    anchors.fill: parent
                    radius: (width+height)/4

                    Text {
                        text: qsTr(fanslider.value.toString())
                        font.pointSize: height * 0.4
                        font.family: "Arial"
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        anchors.fill: parent
                    }
                }
            }
            groove:Item{}
        }
    }

}

