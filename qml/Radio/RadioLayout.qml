import QtQuick 2.5
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.0

Item {
    id: __cclayout
    anchors.fill: parent
    property int left_seat_heat_rate: 0
    property int right_seat_heat_rate: 0


    FontLoader{id:ralewayRegular; source:"qrc:/qml/fonts/Raleway-Regular.ttf"}


    ColumnLayout {
        anchors.bottomMargin: 0
        anchors.bottom: tuner.top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        spacing: 0

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Text {
                color: "#ffffff"
                text: "BBC Radio 1"
                verticalAlignment: Text.AlignBottom
                horizontalAlignment: Text.AlignHCenter
                anchors.fill: parent
                font.pixelSize: 52
                font.family: ralewayRegular.name
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Text {
                color: "#ffffff"
                text: "Now playing: Skrillex - Purple Lamborghini"
                verticalAlignment: Text.AlignTop
                font.family: ralewayRegular.name
                horizontalAlignment: Text.AlignHCenter
                anchors.fill: parent
                font.pixelSize: 25
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            RowLayout {
                anchors.fill: parent
                Item{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Text {
                        id:frequencyText
                        color: "#ffffff"
                        text: Math.round(tuner.frequency * 10)/10
                        verticalAlignment: Text.AlignVCenter
                        font.family: ralewayRegular.name
                        horizontalAlignment: Text.AlignRight
                        anchors.fill: parent
                        font.pixelSize: 100
                    }
                }
                Item{
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Text {
                        color: "#ffffff"
                        text: " MHZ"
                        verticalAlignment: Text.AlignVCenter
                        font.family: ralewayRegular.name
                        horizontalAlignment: Text.AlignLeft
                        anchors.fill: parent
                        font.pixelSize: 60
                    }
                }

            }
        }


    }

    LinearGradient {
            id: mask
            anchors.fill: tuner
            gradient: Gradient {
                GradientStop { position: 0.2; color: "#ffffffff" }
                GradientStop { position: 0.5; color: "#00ffffff" }
            }
            start: Qt.point(0, 0)
            end: Qt.point(300, 0)
            visible: false
        }
    Tuner {
        id:tuner
        height: parent.height * 0.25
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.15
    }

    ThresholdMask  {
        anchors.fill: tuner
        source: tuner
        maskSource: mask
        threshold: 0.9
        spread: 0.2
    }
    Item {
        id: bottom
        height: parent.height * 0.15
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0

        Rectangle {
            color: "#212121"
            anchors.fill: parent
        }

        RowLayout {
            spacing: 0
            anchors.fill: parent
        }
    }

}
