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
        Component {
            id:mediaPlayer
            MediaPlayer {
                bluezManager: __root.bluezManager
                deviceIndex: __root.deviceIndex
            }
        }

        Loader {
            sourceComponent: mediaPlayer
            active: typeof(bluezManager.devices[deviceIndex])!=="undefined" && bluezManager.devices[deviceIndex].mediaPlayer!==null
            id: item3
            anchors.left: dial_buttons.right
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 168
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
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
                            value: bluezManager.operational && bluezManager.adapters[0].powered
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
                            value: bluezManager.operational && bluezManager.adapters[0].discoverable
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
    Connections{
        target: headunit
        onBtConnectionRequest:{
            for(var i = 0 ; i < bluezManager.devices.length; i++){
                if(bluezManager.devices[i].address === address){
                    bluezManager.devices[i].connectToDevice();
                } else {
                    bluezManager.devices[i].disconnectFromDevice();
                }
            }
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
