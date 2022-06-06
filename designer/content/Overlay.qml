import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import HUDTheme 1.0
import HUDPlugins 1.0

Item {
    id: __root
    signal close()
    property string source : ""
    property var properties : ({})

    Component.onCompleted: {
        loader.setSource(source, properties)
    }

    Rectangle {
        id: rectangle
        color: "#cc000000"
        anchors.fill: parent
        Loader {
            id: loader
            anchors.fill: parent
            anchors.rightMargin: 8
            anchors.leftMargin: 8
            anchors.bottomMargin: 8
            anchors.topMargin: 8
        }

        ImageIcon {
            id: closeButton
            width: 20
            height: 20
            color: "#ffffff"
            anchors.right: parent.right
            anchors.top: parent.top
            source: "image://icons/close"
            anchors.topMargin: 8
            anchors.rightMargin: 8

            MouseArea {
                id: mouseArea1
                anchors.fill: parent
                onClicked : {
                    __root.close()
                    BottomBarModel.editing = false
                }
            }
        }

    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorColor:"#c0c0c0";height:480;width:640}
}
##^##*/

