import QtQuick 2.5
import MeeGo.QOfono 0.2
import QtQuick.Controls 2.2


Item {
    id:__root
    property string modemPath : ""
    Text {
        id: textLine
        anchors.centerIn: parent
    }


    Text {
        id: textLine2
        anchors.top: textLine.bottom
        text: manager.available ? netreg.name : "Ofono not available"
    }



    OfonoManager {
        id: manager
        onAvailableChanged: {
            console.log("Ofono is " + available)
            console.log("modems: " + modems + " | selected modems : " + manager.modems[0]);
            netreg.currentOperatorPath
            //var tmp = netreg.currentOperator;
            textLine2.text = manager.available ? netreg.currentOperatorPath :"Ofono not available"
            __root.modemPath = manager.modems[0]
        }
        onModemAdded: {
            console.log("modem added ")
        }
        onModemRemoved: {
            console.log("modem removed")
        }
    }


    MouseArea {
        anchors.rightMargin: 0
        anchors.bottomMargin: -8
        anchors.leftMargin: 0
        anchors.topMargin: 8
        anchors.fill: parent
        onClicked: {
            context1.active = !context1.active
        }
    }

    Button {
        id: button
        x: 176
        y: 101
        width: 104
        height: 40
        text: qsTr("Button")
        onClicked: {
            vcm.hangupAll()
            vcm.dial("07778334130","default")
        }
    }

    OfonoConnMan {
        id: ofono1
        modemPath: __root.modemPath
    }

    OfonoModem {
        id: modem1
        modemPath: __root.modemPath

    }

    OfonoContextConnection {
        id: context1
        //contextPath : ofono1.contexts[0]
        Component.onCompleted: {
            textLine.text = context1.active ? "online" : "offline"
        }
        onActiveChanged: {
            textLine.text = context1.active ? "online" : "offline"
        }
    }
    OfonoNetworkRegistration {
        modemPath: __root.modemPath
        id: netreg

        onNetworkOperatorsChanged : {
            console.log("operators :"+netreg.name)
        }
    }
    OfonoNetworkOperator {
        id: netop
    }

    OfonoHandsfree{
        id:hfp
        modemPath:__root.modemPath
        Component.onCompleted: {
            console.log("Features:")
            for (var i ; i < features.length; i++)
                console.log("    "+features[i])
        }
    }

    OfonoVoiceCallManager{
        id:vcm
        modemPath: __root.modemPath
    }
}
