import QtQuick 2.0

Item {
    id: drawer
    FontLoader{id:ralewayRegular; source:"qrc:/qml/fonts/Raleway-Regular.ttf"}

    signal itemClicked(double frequency, var stationName)

    property var listTopMargin: 20
    property var listType: "favourite"
    property var activeStation: ""

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
    }

    Item {
        id: item1
        anchors.fill: parent

        Item {
            id: buttons
            height: 40
            anchors.topMargin: listTopMargin
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0

            Rectangle {
                id: active_button_bg
                width: parent.width/2+spacer.width/2
                color: "#ffffff"
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                opacity: 0.5

                x:if(listType == "all"){
                    0
                } else if(listType == "favourite"){
                    buttons.width/2 - spacer.width/2
                }
                Behavior on x {

                    NumberAnimation {
                        duration: 600
                        easing.type: Easing.OutBounce
                    }
                }
            }

            Rectangle {
                id: all_button
                color: "#f44336"
                anchors.right: spacer.left
                anchors.rightMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 6
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 6
                anchors.left: parent.left
                anchors.leftMargin: 6

                Text {
                    color: "#ffffff"
                    text: qsTr("All")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.fill: parent
                    font.pixelSize: 14
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: listType="all"
                }
            }


            Item {
                id: spacer
                x: parent.width/2-width/2
                width: 6
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
            }


            Rectangle {
                id: fav_button
                color: "#009688"
                anchors.left: spacer.right
                anchors.leftMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 6
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 6
                anchors.right: parent.right
                anchors.rightMargin: 6

                Text {
                    color: "#ffffff"
                    text: qsTr("Favourites")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.fill: parent
                    font.pixelSize: 14
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked:listType="favourite"
                }
            }


        }

        ListView {
            anchors.top: buttons.bottom
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.topMargin: 0
            clip: true
            model: stationModel
            delegate: Item{
                height: favourite||listType == "all"?60:0
                anchors.left: parent.left
                anchors.right: parent.right
                opacity: favourite||listType == "all"

                Rectangle {
                    id: rectangle1
                    color: "#cddc39"
                    anchors.fill: parent
                    visible: activeStation == name
                }

                Rectangle {
                    height: 1
                    color: "#ffffff"
                    opacity: 0.5
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                }
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
                            onClicked: {
                                activeStation = name;
                                drawer.itemClicked(frequency,activeStation);
                            }
                        }
                    }
                }
            }
        }

    }


}
