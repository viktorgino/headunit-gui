import QtQuick 2.0
import QtQuick.Layouts 1.0

Item {
    id: top_button_wrapper
    property var topButtons:[
        {name:"",imageSrc:"qrc:/qml/icons/svg/rear-window-defrost.svg"},
        {name:"",imageSrc:"qrc:/qml/icons/svg/windshield-defrost.svg"},
        {name:"",imageSrc:"qrc:/qml/icons/svg/air-conditioning.svg"},
        {name:"",imageSrc:"qrc:/qml/icons/svg/recirculation.svg"}
    ]

    Rectangle {
        color: "#33ffffff"
        radius: width/2
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height
        width:parent.width

        RowLayout {
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.top: parent.top


            Item {
                Layout.maximumHeight: width
                Layout.maximumWidth: top_button_wrapper.width/(topButtons.length+2)
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
            Repeater{
                model:topButtons.length
                TopButton {
                    Layout.maximumHeight: width
                    Layout.maximumWidth: top_button_wrapper.width/(topButtons.length+2)
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    imageSrc: topButtons[index].imageSrc
                    name:topButtons[index].name
                }
            }

            Item {
                Layout.maximumHeight: width
                Layout.maximumWidth: top_button_wrapper.width/(topButtons.length+2)
                Layout.fillHeight: true
                Layout.fillWidth: true
            }

        }
    }
}
