import QtQuick 2.6
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.0
import Qt.labs.folderlistmodel 2.1
import QuickCross 1.0
Item {
    id: root
    property alias folder: folderModel.folder
    property alias showFiles: folderModel.showFiles
    property bool folderSelectable: false
    property string selectedPath : folderSelectable?folderModel.folder:""
    property alias nameFilters : folderModel.nameFilters

    signal accepted(var path)
    signal rejected()
    function reset (){
        folderModel.folder = "file://"+StandardPaths.standardLocations(StandardPaths.HomeLocation)
    }

    Item {
        id: standardLocations
        width: parent.width*0.3
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: buttons.top
        anchors.bottomMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 0

        ListView {
            id: listView1
            anchors.rightMargin: 8
            anchors.leftMargin: 8
            anchors.bottomMargin: 8
            anchors.topMargin: 8
            anchors.fill: parent
            clip: true
            delegate: Item {
                width: parent.width
                height: 40
                Row {
                    Image {
                        width: 20
                        height: 20
                        source: iconImage
                        mipmap:true
                        ColorOverlay {
                            color:"#424242"
                            anchors.fill: parent
                            enabled: true
                            source: parent
                        }
                    }
                    Text {
                        text: StandardPaths.displayName(path_key)
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: true
                    }
                    spacing: 10
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: folderModel.folder = "file://"+StandardPaths.standardLocations(path_key)
                }
            }
            model: ListModel {
                ListElement {
                    path_key: 8 //HomeLocation
                    iconImage: "qrc:/qml/icons/home.png"
                }
                ListElement {
                    path_key: 0 //DesktopLocation
                    iconImage: "qrc:/qml/icons/folder.png"
                }
                ListElement {
                    path_key: 1 //DocumentsLocation
                    iconImage: "qrc:/qml/icons/document.png"
                }
                ListElement {
                    path_key: 14 //DownloadLocation
                    iconImage: "qrc:/qml/icons/android-download.png"
                }
                ListElement {
                    path_key: 4 //MusicLocation
                    iconImage: "qrc:/qml/icons/music-note.png"
                }
                ListElement {
                    path_key: 5 //MoviesLocation
                    iconImage: "qrc:/qml/icons/videocamera.png"
                }
            }

            ScrollBar.vertical: ScrollBar {
            }
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
            anchors.rightMargin: 8
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: listLayoutButton.left
            Item {
                id: item2
                height: 40
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                Text {
                    text: folderModel.folder.toString().replace(/^(file:\/{2})|(qrc:\/{1})/, "")
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
                    x:5
                    width: 20
                    height: 20
                    source: "qrc:/qml/icons/chevron-up.png"
                    anchors.verticalCenter: parent.verticalCenter
                    mipmap: true
                    ColorOverlay {
                        color:"#424242"
                        anchors.fill: parent
                        enabled: true
                        source: parent
                    }
                }
                Text {
                    x:35
                    text: "Up"
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if(folderModel.parentFolder != folderModel.rootFolder){
                            folderModel.folder = folderModel.parentFolder
                        }
                        folderView.item.currentIndex = -1;
                        if(folderSelectable){
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
            folder:"file://"+StandardPaths.standardLocations(StandardPaths.HomeLocation)
            sortField: FolderListModel.Name
            showDirsFirst: true
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
                Image{
                    fillMode: Image.PreserveAspectFit
                    anchors.rightMargin: 8
                    anchors.leftMargin: 8
                    anchors.bottomMargin: 8
                    anchors.topMargin: 8
                    anchors.fill: parent
                    source: listLayoutButton.checked ? "qrc:/qml/icons/grid.png" : "qrc:/qml/icons/svg/android-list.svg"
                }
            }
        }

        Loader{
            id:folderView
            anchors.top: dir_up.bottom
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.topMargin: 0
            sourceComponent: listLayoutButton.checked?browserListView:browserGridView
        }
        Component{
            id:browserGridView
            Item{
                id:gridRoot
                property alias currentIndex: gridView.currentIndex
                property alias imageSize: sizeSlider.value
                GridView {
                    id:gridView
                    anchors.bottom: sliderLabel.top
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottomMargin: 0
                    clip:true
                    cellWidth: gridRoot.imageSize
                    cellHeight: gridRoot.imageSize
                    model:folderModel
                    highlightMoveDuration : 50
                    currentIndex: -1
                    highlight: Rectangle
                    {
                        color:"#00000000"
                        opacity: 0.5
                        focus: true
                        radius: 2
                        border.width: 1
                        Rectangle
                        {
                            color:"black"
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
                    ScrollBar.vertical: ScrollBar {
                    }
                    delegate: Item {
                        id:folderViewDelegate
                        width: gridView.cellWidth
                        height: gridView.cellHeight

                        Image {
                            id: image
                            anchors.bottom: text1.top
                            anchors.bottomMargin: 8
                            anchors.top: parent.top
                            anchors.topMargin: 8
                            fillMode: Image.PreserveAspectFit
                            anchors.right: parent.right
                            anchors.rightMargin: 8
                            anchors.left: parent.left
                            anchors.leftMargin: 6
                            sourceSize.width: gridRoot.imageSize
                            source: {
                                if(fileIsDir){
                                    return "qrc:/qml/icons/folder.png";
                                }

                                if(["png","jpg", "jpeg", "gif", "tiff"].indexOf(fileSuffix.toLowerCase()) >= 0){
                                    return fileURL;
                                }
                                return "qrc:/qml/icons/document.png";
                            }
                        }

                        Text {
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
                            font.pixelSize: 12
                        }
                        MouseArea {
                            id: mouseArea
                            anchors.leftMargin: 0
                            anchors.fill: parent
                            onClicked: {
                                if(!fileIsDir){
                                    gridView.currentIndex = index;
                                    root.selectedPath = fileURL;
                                } else {
                                    folderModel.folder = fileURL;
                                    gridView.currentIndex = -1;
                                    if(folderSelectable){
                                        root.selectedPath = folderModel.folder
                                    } else {
                                        root.selectedPath = ""
                                    }
                                }
                            }
                        }


                    }
                }
                ThemeFormText {
                    id: sliderLabel
                    text: qsTr("Size")
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.bottom: sizeSlider.top
                    anchors.bottomMargin: 0
                    font.pixelSize: 12
                }

                Slider{
                    id: sizeSlider
                    stepSize: 1
                    from: 50
                    value: 200
                    to: width>10?width/2:200
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                }

            }
        }

        Component{
            id:browserListView
            ListView {
                id: listView
                clip: true
                highlightMoveDuration : 50
                currentIndex : -1
                highlight: Rectangle
                {
                    color:"black"
                    opacity: 0.5
                    focus: true
                }
                delegate: Item {
                    height: 40
                    width:parent.width
                    Image {
                        x:5
                        width: 20
                        height: 20
                        id: folder_image
                        source: fileIsDir?"qrc:/qml/icons/folder.png": "qrc:/qml/icons/document.png"
                        anchors.verticalCenter: parent.verticalCenter
                        mipmap: true
                        ColorOverlay {
                            color:"#424242"
                            anchors.fill: parent
                            enabled: true
                            source: parent
                        }
                    }
                    Text {
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
                            if(!fileIsDir){
                                listView.currentIndex = index;
                                root.selectedPath = fileURL;
                            } else {
                                folderModel.folder = fileURL;
                                listView.currentIndex = -1;
                                if(folderSelectable){
                                    root.selectedPath = folderModel.folder
                                } else {
                                    root.selectedPath = ""
                                }
                            }
                        }
                    }
                }
                ScrollBar.vertical: ScrollBar {
                }
                model: folderModel
            }
        }
    }

    Item {
        id: buttons
        height: 60
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        Button {
            text: qsTr("Cancel")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 16
            onClicked: root.rejected()
        }

        Button {
            text: qsTr("OK")
            enabled: root.selectedPath !== ""
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 16
            onClicked: root.accepted(root.selectedPath)
        }
    }


}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:38;anchors_width:200}
}
 ##^##*/
