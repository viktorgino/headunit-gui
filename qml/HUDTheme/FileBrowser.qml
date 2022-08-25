import QtQuick 2.11
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0
import Qt.labs.folderlistmodel 2.1
import Qt.labs.platform 1.0

import HUDTheme 1.0

Item {
    id: root
    property alias folder: folderModel.folder
    property alias showFiles: folderModel.showFiles
    property bool folderSelectable: false
    property string selectedPath: folderSelectable ? folderModel.folder : ""
    property alias nameFilters: folderModel.nameFilters

    signal accepted(var path)
    signal rejected
    function reset() {
        folderModel.folder = StandardPaths.standardLocations(
                    StandardPaths.HomeLocation)[0]
    }

    Item {
        id: standardLocations
        width: parent.width * 0.3
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: buttons.top
        anchors.bottomMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 0

        ListView {
            id: userFolders

            anchors.bottom: divider.top
            anchors.topMargin: 8
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top

            anchors.rightMargin: 8
            anchors.leftMargin: 8
            anchors.bottomMargin: 20
            clip: true
            delegate: Item {
                width: parent.width
                height: 30
                Row {
                    anchors.verticalCenter: parent.verticalCenter
                    Image {
                        width: 20
                        height: 20
                        source: iconImage
                        mipmap: true
                        ColorOverlay {
                            color: "#424242"
                            anchors.fill: parent
                            enabled: true
                            source: parent
                        }
                    }
                    ThemeFormText {
                        text: StandardPaths.displayName(path_key)
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: true
                    }
                    spacing: 10
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: folderModel.folder = StandardPaths.standardLocations(
                                   path_key)[0]
                }
            }
            model: ListModel {
                ListElement {
                    path_key: 8 //HomeLocation
                    iconImage: "image://icons/home"
                }
                ListElement {
                    path_key: 0 //DesktopLocation
                    iconImage: "image://icons/folder"
                }
                ListElement {
                    path_key: 1 //DocumentsLocation
                    iconImage: "image://icons/document"
                }
                ListElement {
                    path_key: 14 //DownloadLocation
                    iconImage: "image://icons/android-download"
                }
                ListElement {
                    path_key: 4 //MusicLocation
                    iconImage: "image://icons/music-note"
                }
                ListElement {
                    path_key: 5 //MoviesLocation
                    iconImage: "image://icons/videocamera"
                }
            }

            ScrollBar.vertical: ThemeScrollBar {}
        }
        Rectangle {
            id: divider
            y: parent.height * 0.75
            height: 1
            color: "#424242"
            anchors.left: parent.left
            anchors.right: parent.right
        }

        ListView {
            id: drives
            clip: true
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            anchors.top: divider.bottom
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 8
            anchors.right: parent.right
            anchors.rightMargin: 8
            delegate: Item {
                height: 30
                anchors.left: parent.left
                anchors.right: parent.right
                ThemeFormText {
                    text: modelData.name
                    elide: Text.ElideLeft
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: folderModel.folder = modelData.path
                }
            }
            model: getMountedVolumes()

            ScrollBar.vertical: ThemeScrollBar {}
        }

        Rectangle {
            id: rectangle
            width: 1
            color: "#424242"
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
        }
    }

    Item {
        id: item1
        anchors.rightMargin: 8
        anchors.bottomMargin: 0
        anchors.topMargin: 8
        anchors.left: standardLocations.right
        anchors.right: parent.right
        anchors.bottom: buttons.top
        anchors.top: parent.top
        anchors.leftMargin: 8

        Item {
            id: dir_up
            height: 80
            anchors.rightMargin: 6
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: listZoomButton.left
            Item {
                id: item2
                height: 40
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                ThemeFormText {
                    text: folderModel.folder.toString().replace(
                              /^(file:\/{2})|(qrc:\/{1})/, "")
                    elide: Text.ElideLeft
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                }
            }
            Item {
                height: 40
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                Image {
                    x: 5
                    width: 20
                    height: 20
                    source: "image://icons/chevron-up"
                    anchors.verticalCenter: parent.verticalCenter
                    mipmap: true
                    ColorOverlay {
                        color: "#424242"
                        anchors.fill: parent
                        enabled: true
                        source: parent
                    }
                }
                ThemeFormText {
                    x: 35
                    text: "Up"
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (folderModel.parentFolder != folderModel.rootFolder) {
                            folderModel.folder = folderModel.parentFolder
                        }
                        folderView.item.currentIndex = -1
                        if (folderSelectable) {
                            root.selectedPath = folderModel.folder
                        } else {
                            root.selectedPath = ""
                        }
                    }
                }
            }
        }

        FolderListModel {
            id: folderModel
            showFiles: true
            showHidden: false
            showDotAndDotDot: false
            showOnlyReadable: true
            folder: StandardPaths.standardLocations(
                        StandardPaths.HomeLocation)[0]
            sortField: FolderListModel.Name
            showDirsFirst: true
        }

        Button {
            id: listZoomButton
            anchors.right: listLayoutButton.left
            anchors.rightMargin: 6
            width: height
            height: 40
            anchors.verticalCenter: dir_up.verticalCenter
            visible : !listLayoutButton.checked
            background: Rectangle {
                anchors.fill: parent
                opacity: listLayoutButton.down ? 0.8 : 1
                border.color: "#000000"
                border.width: 1
                color: "#CACACA"
                radius: 5
                Image {
                    fillMode: Image.PreserveAspectFit
                    anchors.rightMargin: 8
                    anchors.leftMargin: 8
                    anchors.bottomMargin: 8
                    anchors.topMargin: 8
                    anchors.fill: parent
                    source: "image://icons/arrow-expand"
                }
            }
            onClicked: {
                popup.open()
            }

            Popup {
                id: popup
                x: 0
                y: 0
                width: 70
                height: 300
                modal: true
                focus: true
                closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
                Slider {
                    id: sizeSlider
                    stepSize: 1
                    from: 2
                    value: 5
                    to: 25
                    anchors.fill : parent
                    wheelEnabled: true
                    orientation: Qt.Vertical
                }
            }
        }

        Button {
            id: listLayoutButton
            anchors.right: parent.right
            anchors.rightMargin: 8
            checkable: true
            width: height
            height: 40
            anchors.verticalCenter: dir_up.verticalCenter
            background: Rectangle {
                anchors.fill: parent
                opacity: listLayoutButton.down ? 0.8 : 1
                border.color: "#000000"
                border.width: 1
                color: "#CACACA"
                radius: 5
                Image {
                    fillMode: Image.PreserveAspectFit
                    anchors.rightMargin: 8
                    anchors.leftMargin: 8
                    anchors.bottomMargin: 8
                    anchors.topMargin: 8
                    anchors.fill: parent
                    source: listLayoutButton.checked ? "image://icons/grid" : "image://icons/android-list"
                }
            }
        }

        Loader {
            id: folderView
            anchors.top: dir_up.bottom
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.topMargin: 0
            sourceComponent: listLayoutButton.checked ? browserListView : browserGridView
        }
        Component {
            id: browserGridView
            GridView {
                id: gridView
                clip: true
                cellWidth: width / sizeSlider.value
                cellHeight: cellWidth
                model: folderModel
                highlightMoveDuration: 50
                currentIndex: -1
                highlight: Rectangle {
                    color: "#00000000"
                    opacity: 0.5
                    focus: true
                    radius: 2
                    border.width: 1
                    Rectangle {
                        color: "black"
                        opacity: 0.5
                        focus: true
                        radius: 2
                        anchors.fill: parent
                    }
                    states: [
                        State {
                            name: "State1"
                        }
                    ]
                }
                ScrollBar.vertical: ScrollBar {}
                delegate: Item {
                    id: folderViewDelegate
                    width: gridView.cellWidth
                    height: gridView.cellHeight

                    ImageIcon {
                        id: image
                        anchors.bottom: text1.top
                        anchors.bottomMargin: 8
                        anchors.top: parent.top
                        anchors.topMargin: 8
                        anchors.right: parent.right
                        anchors.rightMargin: 8
                        anchors.left: parent.left
                        anchors.leftMargin: 6
                        source: {
                            if (fileIsDir) {
                                return "image://icons/folder"
                            }

                            if (["png", "jpg", "jpeg", "gif", "tiff"].indexOf(
                                        fileSuffix.toLowerCase()) >= 0) {
                                return fileURL
                            }
                            return "image://icons/document"
                        }
                    }

                    ThemeText {
                        id: text1
                        text: fileName
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 8
                        elide: Text.ElideMiddle
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 8
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                    }
                    MouseArea {
                        id: mouseArea
                        anchors.leftMargin: 0
                        anchors.fill: parent
                        onClicked: {
                            if (!fileIsDir) {
                                gridView.currentIndex = index
                                root.selectedPath = fileURL
                            } else {
                                folderModel.folder = fileURL
                                gridView.currentIndex = -1
                                if (folderSelectable) {
                                    root.selectedPath = folderModel.folder
                                } else {
                                    root.selectedPath = ""
                                }
                            }
                        }
                    }
                }
            }
        }

        Component {
            id: browserListView
            ListView {
                id: listView
                clip: true
                highlightMoveDuration: 50
                currentIndex: -1
                highlight: Rectangle {
                    color: "black"
                    opacity: 0.5
                    focus: true
                }
                delegate: Item {
                    height: 40
                    width: parent.width
                    Image {
                        x: 5
                        width: 20
                        height: 20
                        id: folder_image
                        source: fileIsDir ? "image://icons/folder" : "image://icons/document"
                        anchors.verticalCenter: parent.verticalCenter
                        mipmap: true
                        ColorOverlay {
                            color: "#424242"
                            anchors.fill: parent
                            enabled: true
                            source: parent
                        }
                    }
                    ThemeFormText {
                        text: fileName
                        anchors.left: folder_image.right
                        anchors.leftMargin: 8
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: true
                    }
                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        onClicked: {
                            if (!fileIsDir) {
                                listView.currentIndex = index
                                root.selectedPath = fileURL
                            } else {
                                folderModel.folder = fileURL
                                listView.currentIndex = -1
                                if (folderSelectable) {
                                    root.selectedPath = folderModel.folder
                                } else {
                                    root.selectedPath = ""
                                }
                            }
                        }
                    }
                }

                ScrollBar.vertical: ThemeScrollBar {}
                model: folderModel
            }
        }
    }

    Item {
        id: buttons
        height: 25
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        Button {
            height: 25
            text: qsTr("Cancel")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 16
            onClicked: root.rejected()
        }

        Button {
            height: 25
            text: qsTr("OK")
            enabled: root.selectedPath !== ""
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 16
            onClicked: root.accepted(root.selectedPath)
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

