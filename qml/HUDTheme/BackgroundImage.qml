import QtQuick 2.6
import Qt.labs.folderlistmodel 2.2

Item {
    id:__root

    function setBackground(){
        if(HUDStyle.background.image){
            if(HUDStyle.background.slideshow){
                loader.sourceComponent = imageSlideshowComponent
            } else {
                loader.sourceComponent = imageComponent
            }
        } else {
            loader.sourceComponent = colorComponent
        }
    }

    Component.onCompleted: {
        __root.setBackground()
    }

    Loader{
        id:loader
        anchors.fill: parent
        sourceComponent: colorComponent
    }

    Connections{
        target: HUDStyle.background
        onImageChanged:{
            __root.setBackground()
        }
        onSlideshowChanged:{
            __root.setBackground()
        }
    }

    Component {
        id:colorComponent
        Rectangle {
            anchors.fill: parent
            color: HUDStyle.background.color
        }
    }

    Component {
        id:imageSlideshowComponent
        Image {
            visible: HUDStyle.background.image
            id: image
            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent
            sourceSize.width: __root.width
            property int i : 0
            source:folderModel.get(0, "fileURL")?folderModel.get(0, "fileURL"):""
            FolderListModel {
                id: folderModel
                nameFilters: ["*.png", "*.jpg"]
                showDirs: false
                showDotAndDotDot: false
                showFiles: true
                onFolderChanged: image.i = 0
                folder: HUDStyle.background.slideshowPath
            }

            Timer {
                interval: HUDStyle.background.slideshowTime * 1000; running:true; repeat: true
                onTriggered: {
                    if(image.i++ >= folderModel.count - 1){
                        image.i = 0;
                    }
                    image.source = folderModel.get(image.i, "fileURL");
                }
            }
        }
    }
    Component {
        id:imageComponent
        Image {
            visible: HUDStyle.background.image
            id: image
            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent
            source : HUDStyle.background.imagePath
            sourceSize.width: __root.width
        }
    }
}
