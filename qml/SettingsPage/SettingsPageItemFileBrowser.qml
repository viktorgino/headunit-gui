import QtQuick 2.7
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

import HUDTheme 1.0

SettingsPageItem {
    id:__root

    property string initPath : ""
    property string browserType : "file"
    property string nameFilters : "*"

    ThemeFormText {
        width: parent.width / 2
        text: __root.value
        elide: Text.ElideMiddle
        anchors.right: parent.right
        anchors.rightMargin: 40
        anchors.verticalCenter: parent.verticalCenter
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            popup.open()
        }
    }
    Popup {
        id: popup
        implicitWidth: window.width * 0.8
        implicitHeight: window.height * 0.8
        leftMargin: window.width * 0.1
        rightMargin: window.width * 0.1
        topMargin: window.height * 0.1
        bottomMargin: window.height * 0.1
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

        onOpened: {
        }
        background: Rectangle {
            color: HUDStyle.Colors.formPopupBackground
        }

        FileBrowser {
            id:fileBrowser
            width: popup.width
            height: popup.height
            anchors.fill: parent
            folder : __root.value
            nameFilters : __root.nameFilters
            showFiles : (__root.browserType === "file")
            folderSelectable : (__root.browserType === "folder")
            onRejected: popup.close()
            onAccepted: {
                onRejected: popup.close()
                __root.value = selectedPath
            }
        }
    }

}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:600}
}
 ##^##*/
