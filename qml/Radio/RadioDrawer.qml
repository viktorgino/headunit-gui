import QtQuick 2.0

Item {
    id: drawer
    FontLoader{id:ralewayRegular; source:"qrc:/qml/fonts/Raleway-Regular.ttf"}

    signal itemClicked(double frequency)

    property var listTopMargin: 0

    ListModel {
        id: stationModel
        ListElement {name:"Radio 1";favourite:true;frequency:87.9}
        ListElement {name:"KISS";favourite:false;frequency:107}
        ListElement {name:"Classic FM";favourite:false;frequency:102.4}
        ListElement {name:"Sunrise Radio";favourite:false;frequency:93.7}
        ListElement {name:"Jazz FM";favourite:false;frequency:95.6}
        ListElement {name:"Fun Kids";favourite:true;frequency:89.2}
        ListElement {name:"Magic Chilled";favourite:false;frequency:88.1}
        ListElement {name:"Capital";favourite:false;frequency:97.8}
        ListElement {name:"UndergroundFm";favourite:true;frequency:96.3}
        ListElement {name:"Kool London";favourite:true;frequency:107}
        ListElement {name:"Bassjunkees.com";favourite:false;frequency:96.7}
        ListElement {name:"BassPort FM";favourite:false;frequency:91.6}
        ListElement {name:"Rude FM";favourite:false;frequency:100.1}
        ListElement {name:"Revolution DJ";favourite:false;frequency:99.3}
        ListElement {name:"Street Certified Radio";favourite:true;frequency:106.2}
    }

    Rectangle {
        color: "#64b5f6"
        anchors.fill: parent
        ListView {
            anchors.topMargin: listTopMargin
            anchors.fill: parent
            model: stationModel
            delegate: Item{
                height: 60
                anchors.left: parent.left
                anchors.right: parent.right

                Item {
                    anchors.rightMargin: parent.height*0.1
                    anchors.leftMargin: parent.height*0.1
                    anchors.bottomMargin: parent.height*0.1
                    anchors.topMargin: parent.height*0.1
                    anchors.fill: parent

                    Image {
                        id: favimage
                        width: height
                        fillMode: Image.PreserveAspectFit
                        anchors.left: parent.left
                        anchors.leftMargin: 0
                        anchors.top: parent.top
                        anchors.topMargin: parent.height*0.2
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: parent.height*0.2
                        source: favourite?"../icons/svg/android-star.svg":"../icons/svg/android-star-outline.svg"
                        //source: "../icons/svg/android-star-outline.svg"

                        MouseArea {
                            anchors.fill: parent
                            onClicked: favourite=!favourite
                        }
                    }

                    Text{
                        color: "#ffffff"
                        text:name
                        font.pointSize: 10
                        anchors.left: favimage.right
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.top: parent.top
                        anchors.leftMargin: 16
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        MouseArea {
                            anchors.fill: parent
                            onClicked: drawer.itemClicked(frequency)
                        }
                    }
                }
            }

        }
    }
}
