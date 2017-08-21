import QtQuick 2.5
import MeeGo.QOfono 0.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    id:__root
    property string modemPath : ""
    Item {
        id: item1
        anchors.top: item2.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.rightMargin: 8
        anchors.leftMargin: 8
        anchors.bottomMargin: 8
        anchors.topMargin: 0


        GridLayout {
            id: gridLayout
            width: parent.width * 0.5
            rows: 4
            columns: 3
            anchors.left: parent.left
            anchors.bottom: dial_buttons.top
            anchors.top: parent.top
            Repeater{
                id: dial_nums
                model:ListModel {
                    ListElement {
                        name: "1"
                    }

                    ListElement {
                        name: "2"
                    }

                    ListElement {
                        name: "3"
                    }

                    ListElement {
                        name: "4"
                    }

                    ListElement {
                        name: "5"
                    }

                    ListElement {
                        name: "6"
                    }

                    ListElement {
                        name: "7"
                    }

                    ListElement {
                        name: "8"
                    }
                    ListElement {
                        name: "9"
                    }
                    ListElement {
                        name: "*"
                    }
                    ListElement {
                        name: "0"
                    }
                    ListElement {
                        name: "#"
                    }
                }
                delegate: Item {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Text{
                        text:model.name
                        font.pointSize: height > 0 ? height * 0.6 : 12
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        anchors.fill: parent

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            onClicked: dialer_num.insert(dialer_num.cursorPosition,parent.text)
                        }
                    }
                }
            }
        }

        Item {
            id: dial_buttons
            height: parent.height * 0.2
            anchors.right: gridLayout.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left

            Rectangle {
                id:dial
                width: height
                color: "#558b2f"
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.top: parent.top
                anchors.topMargin: 8
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8

                Image {
                    id: image1
                    anchors.rightMargin: parent.width*0.1
                    anchors.leftMargin: parent.width*0.1
                    anchors.bottomMargin: parent.height*0.1
                    anchors.topMargin: parent.height*0.1
                    fillMode: Image.PreserveAspectFit
                    anchors.fill: parent
                    source: "qrc:/qml/icons/svg/android-call.svg"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        vcm.dial(dialer_num.text, "");
                    }
                }
            }

            Rectangle {
                id:mic
                width: height
                color: "#1e88e5"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 8
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8

                Image {
                    anchors.rightMargin: parent.width*0.1
                    anchors.leftMargin: parent.width*0.1
                    anchors.bottomMargin: parent.height*0.1
                    anchors.topMargin: parent.height*0.1
                    fillMode: Image.PreserveAspectFit
                    anchors.fill: parent
                    source: "qrc:/qml/icons/svg/mic-a.svg"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        hands_free.voiceRecognition = true;
                    }
                }
            }

            Rectangle {
                id:hangup
                width: height
                color: "#c62828"
                anchors.right: parent.right
                anchors.rightMargin: 8
                anchors.top: parent.top
                anchors.bottomMargin: 8
                anchors.topMargin: 8
                anchors.bottom: parent.bottom

                Image {
                    id: image2
                    anchors.bottomMargin: 0
                    anchors.rightMargin: parent.width*0.1
                    anchors.leftMargin: parent.width*0.1
                    anchors.topMargin: parent.height*0.15
                    rotation: 135
                    anchors.fill: parent
                    source: "qrc:/qml/icons/svg/android-call.svg"
                    fillMode: Image.PreserveAspectFit
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        vcm.hangupAll();
                    }
                }
            }
        }

        TextField {
            id: dialer_num
            text: "+"
            font.pointSize: 30
            anchors.left: gridLayout.right
            anchors.right: parent.right
            anchors.top: parent.top
            validator: RegExpValidator { regExp :/[+]?[0-9#*]*/}

            Image {
                id: image
                width: height * 1.2
                fillMode: Image.PreserveAspectFit
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                source: "qrc:/qml/icons/svg/backspace-outline.svg"

                MouseArea {
                    id: mouseArea1
                    anchors.fill: parent
                    onClicked: {
                        dialer_num.remove(dialer_num.cursorPosition-1, dialer_num.cursorPosition);
                    }
                }
            }
        }
    }

    Item {
        id: item2
        height: parent.height*0.1
        anchors.top: parent.top
        anchors.topMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.right: parent.right
        anchors.rightMargin: 8

        Text {
            id: text1
            text: netreg.name
            anchors.left: parent.left
            anchors.leftMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 22
        }


        Text {
            id: text5
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.right: text2.left
            anchors.rightMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 22
        }

        Text {
            id: text2
            text: netreg.status
            fontSizeMode: Text.VerticalFit
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 22
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: text3
            text: "technology: " + netreg.technology
            anchors.right: text4.left
            anchors.rightMargin: 5
            font.pixelSize: 22
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: text4
            text: qsTr("Signal: ")+netreg.strength + "%"
            anchors.right: parent.right
            anchors.rightMargin: 8
            font.pixelSize: 22
            anchors.verticalCenter: parent.verticalCenter
        }

    }

    OfonoNetworkRegistration {
        modemPath: __root.modemPath
        id: netreg

        onNetworkOperatorsChanged : {
            console.log("operators :"+netreg.name)
        }
    }

    OfonoManager {
        id: manager
        onAvailableChanged: {
            /*console.log("Ofono is " + available)
            console.log("modems: " + modems + " | selected modems : " + manager.modems[0]);
            //netreg.currentOperatorPath*/
            if(available){
                //textLine2.text = manager.available ? netreg.currentOperatorPath :"Ofono not available"
                __root.modemPath = manager.modems[0]
                phonebook.beginImport();
            }
        }
        onModemAdded: {
            __root.modemPath = manager.modems[0]
        }
        onModemRemoved: {
            __root.modemPath = ""
        }
    }

    OfonoVoiceCallManager{
        id:vcm
        modemPath: __root.modemPath
        onCallAdded: {
            console.log(call)
            voice_call.voiceCallPath = call
        }
        onCallRemoved: {
            voice_call.voiceCallPath = call
        }
    }
    OfonoVoiceCall{
        id:voice_call
        onIncomingLineChanged: {
            console.log("onIncomingLineChanged");
        }
        onAnswerComplete: {
            console.log("onAnswerComplete");
        }
        onHangupComplete: {
            console.log("onHangupComplete");
        }
        onDeflectComplete: {
            console.log("onDeflectComplete");
        }
        onStateChanged: {
            console.log("onStateChanged : " + state);
        }
    }
    OfonoPhonebook{
        id:phonebook
        modemPath: __root.modemPath
        onImportReady: {
            console.log("onImportReady")
            console.log(vcardData)
        }
    }
    OfonoHandsfree{
        id:hands_free
        modemPath: __root.modemPath
        Component.onCompleted: {
            text5.text = hands_free.batteryChargeLevel
        }
    }
    OfonoHandsfreeAudioManager{
        id:audio_man
        modemPath: __root.modemPath
        onCardAdded: {
            console.log("onCardAdded")
        }
        onCardRemoved: {
            console.log("onCardRemoved")
        }
        Component.onCompleted: {
            console.log("Cards:");
            for(var i = 0; cards() < i; i++){
                console.log("    "+cards()[i]);
            }
        }
    }
}
