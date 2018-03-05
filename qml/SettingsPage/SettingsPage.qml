import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0

Item {
    id: root
    clip: true

    Rectangle {
        color: "#fafafa"
        anchors.fill: parent
    }

    Item {
        id: main
        width: parent.width
        anchors.bottom: parent.bottom
        anchors.top: parent.top


        ListView {
            id: listView
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: parent.height * 0.15
            anchors.bottomMargin: 0
            clip: true
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            delegate:SettingsPageItem{
                onElemClicked: {
                    if(source){
                        root.state = "page loaded"
                        pageLoader.source = source
                        pageText.text = text
                    }
                }
            }

            model: configItems
            section.property: "section"
            section.criteria: ViewSection.FullString
            section.delegate: SettingsPageSectionHeader{

            }
        }

        Item {
            id: header
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            height:parent.height * 0.15

            Item {
                id: item2
                clip: true
                anchors.bottomMargin: -20
                anchors.fill: parent

                RectangularGlow {
                    id: effect
                    anchors.fill: rect
                    glowRadius: 20
                    spread: -0.1
                    color: "#000000"
                    cornerRadius: 0
                }

                Rectangle {
                    id: rect
                    color: "#3f51b5"
                    clip: true
                    anchors.bottomMargin: 20
                    anchors.fill: parent
                }


            }

            Image {
                id: image
                width: height
                height: parent.height/2
                anchors.leftMargin: width/2
                anchors.verticalCenter: parent.verticalCenter
                fillMode: Image.PreserveAspectFit
                anchors.left: parent.left
                source: "qrc:/qml/icons/android-settings.png"
                mipmap:true

                ColorOverlay {
                    color: "#ffffff"
                    anchors.fill: parent
                    enabled: true
                    source: parent
                }
            }



            Text {
                id: text1
                color: "#ffffff"
                text: qsTr("Settings")
                font.pixelSize: parent.height /4
                anchors.leftMargin: image.width/2
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: image.right
                anchors.right: parent.right
                anchors.rightMargin: 15
            }

        }
    }

    Item {
        id: settingPage
        width:parent.width
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        x:parent.width


        Loader {
            id: pageLoader
            anchors.top: header1.bottom
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.topMargin: 0
        }

        Item {
            id: header1
            x: -7
            y: -3
            height: parent.height * 0.15
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: parent.top
            Item {
                id: item3
                anchors.fill: parent
                anchors.bottomMargin: -20
                RectangularGlow {
                    id: effect1
                    color: "#000000"
                    anchors.fill: rect1
                    cornerRadius: 0
                    spread: -0.1
                    glowRadius: 20
                }

                Rectangle {
                    id: rect1
                    color: "#3f51b5"
                    anchors.fill: parent
                    anchors.bottomMargin: 20
                    clip: true
                }
                clip: true
            }

            Image {
                id: image1
                width: height
                height: parent.height/2
                mipmap: true
                anchors.leftMargin: width/2
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                fillMode: Image.PreserveAspectFit
                source: "qrc:/qml/icons/svg/android-arrow-back.svg"
                ColorOverlay {
                    color: "#ffffff"
                    anchors.fill: parent
                    source: parent
                    enabled: true
                }

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    onClicked: root.state = "base state"
                }
            }

            Text {
                id: pageText
                color: "#ffffff"
                text: qsTr("Settings")
                anchors.leftMargin: image1.width/2
                anchors.right: parent.right
                anchors.rightMargin: 15
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: image1.right
                font.pixelSize: parent.height /4
            }
        }
    }

    states: [
        State {
            name: "page loaded"

            PropertyChanges {
                target: main
                x: -parent.width
            }

            PropertyChanges {
                target: settingPage
                x: 0
            }
        }
    ]
}
