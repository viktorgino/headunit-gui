import QtQml 2.2
import QtQuick 2.6
import MeeGo.QOfono 0.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtBluetooth 5.7
import org.kde.bluezqt 1.0 as BluezQt
import "../theme"
Item {
    id:__root
    property int deviceIndex: 0
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
                        font.bold: true
                        font.pointSize: height > 0 ? height * 0.6 : 12
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        anchors.fill: parent
                        scale: mouseArea.pressed ? 0.96 : 1.0

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            onClicked: dialer_num.insert(dialer_num.cursorPosition,parent.text)
                        }

                    }

                    Rectangle {
                          id: dial_field
                          anchors.horizontalCenter: parent.horizontalCenter
                          anchors.verticalCenter: parent.verticalCenter
                          height: parent.height-15
                          width: height
                          border.color: "black"
                          border.width: 4
                          radius: width*0.5-20
                          color: mouseArea.pressed ? "grey" : "white"
                          scale: mouseArea.pressed ? 0.96 : 1.0
                          z: -1
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
                id: dial
                width: height
                border.color: "white"
                border.width: 4
                radius: width*0.5
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.top: parent.top
                anchors.topMargin: 8
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8
                color: mouseAreaDial.pressed ? "grey" : "#558b2f"
                scale: mouseAreaDial.pressed ? 0.96 : 1.0

                Image {
                    id: image1
                    anchors.rightMargin: parent.width*0.1
                    anchors.leftMargin: parent.width*0.1
                    anchors.bottomMargin: parent.height*0.1
                    anchors.topMargin: parent.height*0.1
                    fillMode: Image.PreserveAspectFit
                    anchors.fill: parent
                    scale: mouseAreaDial.pressed ? 0.96 : 1.0
                    source: "../icons/svg/android-call.svg"
                }

                MouseArea {
                    id: mouseAreaDial
                    anchors.fill: parent
                    onClicked: {
                        vcm.dial(dialer_num.text, "");
                    }

                }
            }

            Rectangle {
                id:mic
                width: height
                border.color: "white"
                border.width: 4
                radius: width*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 8
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8
                color: mouseAreaMic.pressed ? "grey" : "#1e88e5"
                scale: mouseAreaMic.pressed ? 0.96 : 1.0

                Image {
                    anchors.rightMargin: parent.width*0.1
                    anchors.leftMargin: parent.width*0.1
                    anchors.bottomMargin: parent.height*0.1
                    anchors.topMargin: parent.height*0.1
                    fillMode: Image.PreserveAspectFit
                    anchors.fill: parent
                    scale: mouseAreaMic.pressed ? 0.96 : 1.0
                    source: "../icons/svg/mic-a.svg"
                }
                MouseArea {
                    id: mouseAreaMic
                    anchors.fill: parent
                    onClicked: {
                        hands_free.voiceRecognition = true;
                    }
                }
            }

            Rectangle {
                id:hangup
                width: height
                border.color: "white"
                border.width: 4
                radius: width*0.5
                anchors.right: parent.right
                anchors.rightMargin: 8
                anchors.top: parent.top
                anchors.bottomMargin: 8
                anchors.topMargin: 8
                color: mouseAreaHangup.pressed ? "grey" : "#c62828"
                scale: mouseAreaHangup.pressed ? 0.96 : 1.0
                anchors.bottom: parent.bottom

                Image {
                    id: image2
                    anchors.bottomMargin: 0
                    anchors.rightMargin: parent.width*0.1
                    anchors.leftMargin: parent.width*0.1
                    anchors.topMargin: parent.height*0.15
                    rotation: 135
                    anchors.fill: parent
                    scale: mouseAreaHangup.pressed ? 0.96 : 1.0
                    source: "../icons/svg/android-call.svg"
                    fillMode: Image.PreserveAspectFit
                }

                MouseArea {
                    id: mouseAreaHangup
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
            font.bold: false
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

        Item {
            id: item3
            anchors.left: dial_buttons.right
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 168
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0

            Text {
                id: text6
                text: {
                    return bluezManager.devices[__root.deviceIndex].mediaPlayer.track.artist + " - " + bluezManager.devices[__root.deviceIndex].mediaPlayer.track.title
                }
                anchors.bottom: buttons.top
                anchors.bottomMargin: 0
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0
                font.pixelSize: 22
            }

            RowLayout {
                id: buttons
                height: width/6
                anchors.bottom: sliderHorizontal1.top
                anchors.bottomMargin: 8
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0

                /*
             * Currently not working. The following error is returned when trying to set shuffle:
             *      BluezQt: PendingCall Error: "No such property 'Shuffle'"
             */
                //TODO:Look into why BluezQt::MediaPlayer.shuffle is not working
                /*ImageButton{
                id: shuffle_button
                Layout.fillHeight: true
                Layout.fillWidth: true
                checkable: true
                imageSource: "qrc:/qml/icons/shuffle.png"
                changeColorOnPress:false
                onClicked: {
                    if(checked)
                        bluezManager.devices[__root.deviceIndex].mediaPlayer.shuffle = BluezQt.MediaPlayer.ShuffleAllTracks
                    else
                        bluezManager.devices[__root.deviceIndex].mediaPlayer.shuffle = BluezQt.MediaPlayer.ShuffleOff
                }
            }*/

                ImageButton{
                    id: prev_button
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    imageSource: "qrc:/qml/icons/skip-backward.png"
                    onClicked: bluezManager.devices[__root.deviceIndex].mediaPlayer.previous()
                }

                ImageButton{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    imageSource: bluezManager.devices[__root.deviceIndex].mediaPlayer.status == BluezQt.MediaPlayer.Playing?"qrc:/qml/icons/pause.png":"qrc:/qml/icons/play.png"
                    id:playButton
                    onClicked: {
                        if(bluezManager.devices[__root.deviceIndex].mediaPlayer.status == BluezQt.MediaPlayer.Playing)
                            bluezManager.devices[__root.deviceIndex].mediaPlayer.pause()
                        else
                            bluezManager.devices[__root.deviceIndex].mediaPlayer.play()
                    }
                }

                ImageButton{
                    id: next_button
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    imageSource: "qrc:/qml/icons/skip-forward.png"
                    onClicked: bluezManager.devices[__root.deviceIndex].mediaPlayer.next()
                }

                /*
             * Currently not working. The following error is returned when trying to set repeat:
             *      BluezQt: PendingCall Error: "No such property 'Repeat'"
             */
                //TODO:Look into why BluezQt::MediaPlayer.repeat is not working
                /*ImageButton {
                id: loop_button
                Layout.fillHeight: true
                Layout.fillWidth: true
                checked: true
                imageSource: "qrc:/qml/icons/refresh.png"
                changeColorOnPress:false
                text: {
                    switch(bluezManager.devices[__root.deviceIndex].mediaPlayer.repeat){
                    case BluezQt.MediaPlayer.RepeatOff:
                        checked = true;
                        return "1";
                    case BluezQt.MediaPlayer.RepeatSingleTrack:
                        checked = true;
                        return "All";
                    default:
                        checked = false;
                        return "";
                    }
                }
                onClicked: {
                    switch(bluezManager.devices[__root.deviceIndex].mediaPlayer.repeat){
                    case BluezQt.MediaPlayer.RepeatOff:
                        bluezManager.devices[__root.deviceIndex].mediaPlayer.shuffle = BluezQt.MediaPlayer.RepeatSingleTrack
                        break;
                    case BluezQt.MediaPlayer.RepeatSingleTrack:
                        bluezManager.devices[__root.deviceIndex].mediaPlayer.shuffle = BluezQt.MediaPlayer.RepeatAllTracks
                        break;
                    default:
                        bluezManager.devices[__root.deviceIndex].mediaPlayer.shuffle = BluezQt.MediaPlayer.RepeatOff
                        break;
                    }
                }
            }*/
            }

            Slider {
                id: sliderHorizontal1
                y: 42
                anchors.bottom: trackInfo.top
                anchors.bottomMargin: 8
                value: bluezManager.devices[__root.deviceIndex].mediaPlayer.position
                from:0
                to: bluezManager.devices[__root.deviceIndex].mediaPlayer.track.duration
                stepSize: 1
                anchors.right: parent.right
                anchors.rightMargin: 8
                anchors.left: parent.left
                anchors.leftMargin: 8
                enabled: false
            }

            Timer {
                interval: 50; running: bluezManager.devices[__root.deviceIndex].mediaPlayer.status == BluezQt.MediaPlayer.Playing; repeat: true
                property int lastUpdated: 0
                onTriggered: {
                    sliderHorizontal1.value = sliderHorizontal1.value + 50
                }
            }

            Connections{
                target: bluezManager.devices[__root.deviceIndex].mediaPlayer
                onPositionChanged: {
                    sliderHorizontal1.value = position
                }
                onTrackChanged:{
                    sliderHorizontal1.value = bluezManager.devices[__root.deviceIndex].mediaPlayer.position
                }
                onStatusChanged:{
                    sliderHorizontal1.value = bluezManager.devices[__root.deviceIndex].mediaPlayer.position
                }
            }

            Item {
                id: trackInfo
                y: 152
                height: 16
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0

                Text {
                    text: {
                        var position = sliderHorizontal1.value
                        var seconds = parseInt((position / 1000) % 60);
                        var minutes = parseInt((position / (60000 )) % 60);
                        var hours = parseInt((position / (3600000)) % 24);
                        return (hours > 0 ? hours + ":" : "") + minutes + ":" + ("0" + seconds).slice(-2);
                    }
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    font.pixelSize: 12
                }

                Text {
                    text: {
                        var duration = bluezManager.devices[__root.deviceIndex].mediaPlayer.track.duration
                        var seconds = parseInt((duration / 1000) % 60);
                        var minutes = parseInt((duration / (60000)) % 60);
                        var hours = parseInt((duration / (3600000)) % 24);
                        return (hours > 0 ? hours + ":" : "") + minutes + ":" + ("0" + seconds).slice(-2);
                    }
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    font.pixelSize: 12
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }


    }

    Item {
        id: item2
        height: parent.height*0.1
        anchors.top: toolBar.bottom
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
            id: text4
            text: qsTr("Signal: ")+netreg.strength + "%"
            anchors.right: parent.right
            anchors.rightMargin: 8
            font.pixelSize: 22
            anchors.verticalCenter: parent.verticalCenter
        }

    }

    ToolBar {
        id: toolBar
        anchors.top: parent.top
        anchors.topMargin: 8
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 8

        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: qsTr("⋮")
                onClicked: menu.open()
                Menu {
                    id: menu
                    x: -width+parent.width
                    y: parent.height

                    MenuItem {
                        id: menuItem
                        text: "Bluetooth"

                        Switch {
                            id:btPowerSwitch
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            onCheckedChanged: {
                                bluezManager.adapters[0].powered = checked
                            }
                        }
                        Binding {
                            target:btPowerSwitch
                            property: "checked"
                            value: bluezManager.adapters[0].powered
                        }
                    }
                    MenuItem {
                        text: "Visible"

                        Switch {
                            id:btVisibilitySwitch
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            onCheckedChanged: {
                                bluezManager.adapters[0].discoverable = checked
                            }
                        }
                        Binding {
                            target:btVisibilitySwitch
                            property: "checked"
                            value: bluezManager.adapters[0].discoverable
                        }
                    }
                    MenuItem {
                        Rectangle {
                            height: 1
                            color: "#1E000000"
                            anchors.right: parent.right
                            anchors.rightMargin: 8
                            anchors.left: parent.left
                            anchors.leftMargin: 8
                        }
                        Text{
                            height: font.pointSize+16
                            anchors.right: parent.right
                            anchors.rightMargin: 8
                            anchors.left: parent.left
                            anchors.leftMargin: 8
                            text: "Paired Devices"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pointSize: 11
                        }
                    }
                    Instantiator {
                        model:bluezManager.devices
                        onObjectAdded: menu.addItem(object )
                        onObjectRemoved: menu.removeItem( 3+index )
                        delegate: MenuItem {
                            text: name

                            Switch {
                                checked: connected
                                anchors.right: parent.right
                                anchors.rightMargin: 0
                                enabled: true
                                onCheckedChanged: {
                                    if(checked) {
                                        for(var i = 0 ; i < bluezManager.devices.length; i++){
                                            bluezManager.devices[i].disconnectFromDevice();
                                        }
                                        connectToDevice();
                                        __root.deviceIndex = index;
                                    } else {
                                        disconnectFromDevice();
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    property QtObject bluezManager : BluezQt.Manager

    Connections{
        target: bluezManager
        onOperationalChanged:{
        }
    }

    OfonoNetworkRegistration {
        modemPath: ofonomodem.modemPath
        id: netreg
    }

    OfonoManager {
        id: manager
        onAvailableChanged: {
            /*console.log("Ofono is " + available)
            console.log("modems: " + modems + " | selected modems : " + manager.modems[0]);
            //netreg.currentOperatorPath*/
            if(available){
                //textLine2.text = manager.available ? netreg.currentOperatorPath :"Ofono not available"
                ofonomodem.modemPath = manager.modems[0]
            }
        }
        onModemAdded: {
            ofonomodem.modemPath = manager.modems[0]
        }
        onModemRemoved: {
            ofonomodem.modemPath = ""
        }
    }
    OfonoModem{
        id:ofonomodem
        onModemPathChanged: {
            online = true;
            powered = true;
        }
        onPoweredChanged: {
            console.log("name : " + name + " | manufacturer: " + manufacturer + " | model: " + model + " | type: " + type);
        }
    }

    OfonoVoiceCallManager{
        id:vcm
        modemPath: ofonomodem.modemPath
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
    OfonoHandsfree{
        id:hands_free
        modemPath: ofonomodem.modemPath
    }



}
