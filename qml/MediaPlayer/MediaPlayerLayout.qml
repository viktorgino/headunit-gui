import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0
import QtMultimedia 5.7
import QtQuick.Dialogs 1.0
import QtGraphicalEffects 1.0
import "../theme"

Item {
    id: __media_player_layout
    function getReadableTime(milliseconds){
        var minutes = Math.floor(milliseconds / 60000);
        var seconds = ((milliseconds % 60000) / 1000).toFixed(0);
        return (seconds == 60 ? (minutes+1) + ":00" : minutes + ":" + (seconds < 10 ? "0" : "") + seconds);
    }
    property bool isBase: false
    function changeState(caller){
        if(__media_player_layout.state == "" && caller == "button"){
            __media_player_layout.state="drawer";
            top_menu.menuButtonActive = true;
            isBase = false;
        } else if(caller == "button"){
            __media_player_layout.state="";
            top_menu.menuButtonActive = false;
            isBase = false;
        } else if(caller == "toList"){
            __media_player_layout.state="media list";
        } else if(caller == "toContainer"){
            __media_player_layout.state="container list";
        }
    }
    Item {
        id: main
        anchors.top: top_menu.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.topMargin: 0


        Item {
            id: wrapper
            anchors.rightMargin: 15
            anchors.leftMargin: 15
            anchors.bottomMargin: 15
            anchors.topMargin: 15
            anchors.fill: parent

            Image {
                id: thumbnail_image
                width: parent.width * 0.3
                fillMode: Image.PreserveAspectFit
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 0
                source: typeof(mediaplayer.metaData.coverArtUrlLarge) != "undefined"?mediaplayer.metaData.coverArtUrlLarge:""
            }

            Item {
                id: item6
                anchors.left: thumbnail_image.right
                anchors.leftMargin: 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0

                Item {
                    id: track_info
                    height: parent.height * 0.4
                    anchors.bottom: buttons.top
                    anchors.bottomMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 8
                    anchors.left: parent.left
                    anchors.leftMargin: 8

                    Text {
                        id: media_title
                        color: "#ffffff"
                        text: mediaplayer.metaData.title?mediaplayer.metaData.title:""
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        anchors.right: parent.right
                        anchors.rightMargin: 0
                        anchors.left: parent.left
                        anchors.leftMargin: 0
                        anchors.top: parent.top
                        anchors.topMargin: 0
                        font.pixelSize: 24
                    }

                    Text {
                        id: media_author
                        color: "#ffffff"
                        text:mediaplayer.getArtist(mediaplayer.metaData)
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 0
                        anchors.left: parent.left
                        anchors.leftMargin: 0
                        anchors.top: media_title.bottom
                        anchors.topMargin: 0
                        font.pixelSize: 16
                    }

                    Text {
                        id: media_album_title
                        color: "#ffffff"
                        text: mediaplayer.metaData.albumTitle?mediaplayer.metaData.albumTitle:""
                        verticalAlignment: Text.AlignTop
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        anchors.right: parent.right
                        anchors.rightMargin: 0
                        anchors.left: parent.left
                        anchors.leftMargin: 0
                        anchors.top: media_author.bottom
                        anchors.topMargin: 0
                        font.pixelSize: 16
                    }


                }

                RowLayout {
                    id: buttons
                    width: parent.width * 0.5
                    height: width/5
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: slider_wrapper.top
                    anchors.bottomMargin: 0

                    Item {
                        id: item1
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        ImageButton{
                            id: shuffle_button
                        anchors.fill: parent
                            checkable: true
                            checked: (nowPlaying.playbackMode == Playlist.Random)
                            imageSource: "qrc:/qml/icons/shuffle.png"
                            changeColorOnPress:false
                            onClicked: {
                                if(parent.checked){
                                    nowPlaying.playbackMode = Playlist.Random
                                } else {
                                    nowPlaying.playbackMode = Playlist.Sequential
                                }
                            }
                        }
                    }

                    Item {
                        id: item2
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        ImageButton{
                            id: prev_button
                        anchors.fill: parent
                            imageSource: "qrc:/qml/icons/skip-backward.png"
                            onClicked: mediaplayer.playlist.previous()
                        }
                    }

                    Item {
                        id: item3
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        ImageButton{
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            imageSource: "qrc:/qml/icons/play.png"
                            id:playButton
                        anchors.fill: parent
                            onClicked: {
                                switch (mediaplayer.playbackState){
                                case MediaPlayer.PlayingState:
                                    mediaplayer.pause()
                                    break;
                                case MediaPlayer.PausedState:
                                case MediaPlayer.StoppedState:
                                    mediaplayer.play()
                                    break;
                                }
                            }
                        }
                    }

                    Item {
                        id: item4
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        ImageButton{
                            id: next_button
                        anchors.fill: parent
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            imageSource: "qrc:/qml/icons/skip-forward.png"
                            onClicked: mediaplayer.playlist.next()
                        }
                    }

                    Item {
                        id: item5
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        ImageButton {
                            id: loop_button
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            //checked: (nowPlaying.playbackMode == Playlist.CurrentItemInLoop || nowPlaying.playbackMode == Playlist.Loop)
                            imageSource: "qrc:/qml/icons/refresh.png"
                            changeColorOnPress:false
                            text: {
                                switch(nowPlaying.playbackMode){
                                case Playlist.CurrentItemInLoop:
                                    checked=true;
                                    return "1";
                                case Playlist.Loop:
                                    checked=true;
                                    return "All";
                                default:
                                    checked=false;
                                    return "";
                                }
                            }
                        anchors.fill: parent
                            onClicked: {
                                if(nowPlaying.playbackMode == Playlist.Sequential || nowPlaying.playbackMode == Playlist.Random){
                                    nowPlaying.playbackMode = Playlist.CurrentItemInLoop;
                                } else if (nowPlaying.playbackMode == Playlist.CurrentItemInLoop){
                                    nowPlaying.playbackMode = Playlist.Loop;
                                } else {
                                    nowPlaying.playbackMode = Playlist.Sequential;
                                }
                            }
                        }
                    }
                }

                Item {
                    id: slider_wrapper
                    height: parent.height * 0.2
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0

                    Slider {
                        id: sliderHorizontal1
                        anchors.top: parent.top
                        anchors.topMargin: 0
                        value: mediaplayer.position
                        maximumValue: mediaplayer.duration
                        stepSize: 1
                        anchors.right: parent.right
                        anchors.rightMargin: 0
                        anchors.left: parent.left
                        anchors.leftMargin: 0
                        onValueChanged: {
                            if(value != mediaplayer.position){
                                mediaplayer.seek(value)
                            }
                        }
                    }

                    Text {
                        id: text1
                        color: "#ffffff"
                        text: getReadableTime(mediaplayer.position)
                        anchors.top: sliderHorizontal1.bottom
                        anchors.topMargin: 0
                        anchors.left: parent.left
                        anchors.leftMargin: 0
                        font.pixelSize: 12
                    }

                    Text {
                        id: text2
                        color: "#ffffff"
                        text: getReadableTime(mediaplayer.duration)
                        anchors.right: parent.right
                        anchors.rightMargin: 0
                        anchors.top: sliderHorizontal1.bottom
                        font.pixelSize: 12
                        anchors.topMargin: 0
                    }
                }


            }
        }

        Rectangle {
            id: overlay
            color: "#00000000"
            z: 10
            anchors.topMargin: 0
            visible: false
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            opacity: 0.5

            MouseArea {
                id: mouseArea5
                enabled: false
                anchors.fill: parent
                onClicked: changeState("button")
            }

        }
    }

    Playlist{
        id: nowPlaying
        playbackMode : Playlist.Sequential
    }

    MediaPlayer {
        id: mediaplayer
        source: "file:///media/gino/Gino HDD/music/Trap/VA_-_All_Trap_Music_Vol_3-WEB-2014-BiLDERBERG/14-massappeals_-_im_good.mp3"
        playlist: nowPlaying
        autoLoad: true
        audioRole: MediaPlayer.MusicRole
        onPaused: {
            playButton.imageSource = "qrc:/qml/icons/play.png";
        }
        onStopped: {
            playButton.imageSource = "qrc:/qml/icons/play.png";
        }
        onPlaying: {
            playButton.imageSource = "qrc:/qml/icons/pause.png";
        }
        function getArtist(){
            var m = metaData;
            return m.contributingArtist?m.contributingArtist:
                                         m.contributingArtist?m.leadPerformer:
                                                               m.contributingArtist?m.albumArtist:
                                                                                     m.contributingArtist?m.metaData.author:
                                                                                                           m.contributingArtist?m.writer:"";
        }
    }

    MediaList {
        id: mediaList
        width: parent.width * 0.7
        anchors.leftMargin: -1 * width
        opacity: 0
        anchors.top: top_menu.bottom
        anchors.topMargin: 0
        anchors.left: main.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        onItemClicked: {
            changeState("button");
            mediaplayer.playlist.clear();
            var itemToPlay = 0;
            for(var i=0; i<model.length; i++){
                if(model[i].playNow)
                    itemToPlay = i+1;
                mediaplayer.playlist.addItem("file://"+model[i].path + '/' + model[i].name );
            }
            //No function in QT to play a song with a given id so we skip to it
            for(var i=0; i<itemToPlay; i++){
                mediaplayer.playlist.next();
            }
            mediaplayer.play();
            thumbnail_image.source = thumbnail;
        }
        onBack: changeState("toContainer")
    }


    MediaContainerList {
        id: mediaContainerList
        width: parent.width * 0.7
        anchors.leftMargin: parent.width
        opacity: 0
        anchors.top: top_menu.bottom
        anchors.topMargin: 0
        anchors.left: main.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        onItemClicked: {
            changeState("toList");
            mediaList.model = mediaLibrary.audioFolderContent(id);
            mediaList.thumbnail = thumbnail;
            mediaList.title = name;
            mediaList.sub_title = path;
        }
    }


    MediaDrawer {
        id: mediaDrawer
        width: parent.width * 0.3
        top_margin: top_menu.height
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: main.left
        anchors.rightMargin: 0
        onItemClicked: {
            switch(item_type){
            case "folders":
                mediaContainerList.model = mediaLibrary.audioFolders;
                break;
            case "playlists":
                mediaContainerList.model = mediaLibrary.playlists;
                break;
            default:
                mediaContainerList.model = 0;
                break;
            }
            mediaContainerList.icon = icon;
            mediaContainerList.name = name;
            mediaContainerList.item_type = item_type;
            __media_player_layout.changeState("toContainer")
        }
    }

    TopMenu{
        id: top_menu
        height: parent.height*0.10
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        onMenuClicked: changeState("button")
        bg_opacity: overlay.opacity
    }

    states: [
        State {
            name: "drawer"
            PropertyChanges {
                target: main
                anchors.topMargin: 0
                anchors.rightMargin: -1* parent.width * 0.3
                anchors.leftMargin: parent.width * 0.3
            }

            PropertyChanges {
                target: overlay
                visible: true
            }

            PropertyChanges {
                target: mouseArea5
                enabled: true
                opacity: 1
            }
        },
        State {
            name: "container list"

            PropertyChanges {
                target: main
                anchors.topMargin: 0
                anchors.rightMargin: -1* parent.width * 0.3
                anchors.leftMargin: parent.width * 0.3
            }

            PropertyChanges {
                target: overlay
                color: "#000000"
                opacity: 0.9
                visible: true
            }

            PropertyChanges {
                target: mediaContainerList
                anchors.leftMargin: 0
                opacity: 1
                visible: true
            }

            PropertyChanges {
                target: __media_player_layout
                clip: true
            }
        },
        State {
            name: "media list"
            PropertyChanges {
                target: main
                anchors.leftMargin: parent.width * 0.3
                anchors.rightMargin: -1* parent.width * 0.3
                anchors.topMargin: 0
            }

            PropertyChanges {
                target: overlay
                color: "#000000"
                opacity: 0.9
                visible: true
            }

            PropertyChanges {
                target: mediaContainerList
                opacity: 0.5
                visible: false
            }

            PropertyChanges {
                target: __media_player_layout
                clip: true
            }

            PropertyChanges {
                target: mediaList
                anchors.leftMargin: 0
                opacity: 1
                visible: true
            }
        }
    ]
    transitions:
        Transition {
        SequentialAnimation {
            NumberAnimation { properties: "anchors.leftMargin,anchors.rightMargin,opacity,width"; duration: 250}
            NumberAnimation { properties: "visible"; duration: 1}
        }
    }
}
