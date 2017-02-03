import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0
import QtMultimedia 5.7
import QtQuick.Dialogs 1.0

Item {
    id: item1
    function getReadableTime(milliseconds){
        var minutes = Math.floor(milliseconds / 60000);
        var seconds = ((milliseconds % 60000) / 1000).toFixed(0);
        return (seconds == 60 ? (minutes+1) + ":00" : minutes + ":" + (seconds < 10 ? "0" : "") + seconds);
    }

    Item {
        id: item2
        anchors.rightMargin: 15
        anchors.leftMargin: 15
        anchors.bottomMargin: 15
        anchors.topMargin: 15
        anchors.fill: parent

        Image {
            id: image1
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: track_info.top
            anchors.bottomMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 8
            source: mediaplayer.metaData.coverArtUrlLarge
        }

        Item {
            id: track_info
            x: 8
            y: 192
            height: parent.height * 0.2
            anchors.bottom: buttons.top
            anchors.bottomMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 8
            anchors.left: parent.left
            anchors.leftMargin: 8

            Text {
                id: media_title
                text: qsTr(mediaplayer.metaData.title)
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 24
            }
            Text {
                id: media_author
                text: qsTr(mediaplayer.metaData.leadPerformer)
                anchors.top: media_title.bottom
                anchors.topMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 16
            }
            Text {
                id: media_album_title
                text: qsTr(mediaplayer.metaData.albumTitle)
                anchors.top: media_author.bottom
                anchors.topMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 16
            }
        }


        RowLayout {
            id: buttons
            x: 8
            y: 288
            height: parent.height * 0.2
            anchors.bottom: slider_wrapper.top
            anchors.bottomMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 8
            anchors.left: parent.left
            anchors.leftMargin: 8

            Image {
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                Layout.fillHeight: true
                Layout.fillWidth: true
                source: "qrc:/qml/icons/shuffle.png"

                MouseArea {
                    id: mouseArea4
                    anchors.fill: parent
                    onClicked: nowPlaying.shuffle()
                }
            }

            Image {
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                Layout.fillHeight: true
                Layout.fillWidth: true
                source: "qrc:/qml/icons/skip-backward.png"

                MouseArea {
                    id: mouseArea2
                    anchors.fill: parent
                    onClicked: mediaplayer.playlist.previous()
                }
            }

            Image {
                id:playButton
                width: 100
                height: 100
                Layout.fillWidth: true
                Layout.fillHeight: true
                source: "qrc:/qml/icons/play.png"
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    onClicked:{
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

            Image {
                width: 100
                height: 100
                Layout.fillWidth: true
                Layout.fillHeight: true
                source: "qrc:/qml/icons/skip-forward.png"
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    id: mouseArea1
                    anchors.fill: parent
                    onClicked: mediaplayer.playlist.next()
                }
            }

            Image {
                width: 100
                height: 100
                Layout.fillWidth: true
                Layout.fillHeight: true
                source: "qrc:/qml/icons/refresh.png"
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    id: mouseArea3
                    anchors.fill: parent
                    onClicked: mediaplayer.loops = MediaPlayer.Infinite
                }
            }

        }

        Item {
            id: slider_wrapper
            x: 0
            y: 384
            height: parent.height * 0.2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0

            Slider {
                id: sliderHorizontal1
                x: 0
                y: -360
                height: 48
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
                text: getReadableTime(mediaplayer.position)
                anchors.top: sliderHorizontal1.bottom
                anchors.topMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                font.pixelSize: 12
            }

            Text {
                id: text2
                x: 2
                text: getReadableTime(mediaplayer.duration)
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.top: sliderHorizontal1.bottom
                font.pixelSize: 12
                anchors.topMargin: 0
            }
        }




    }

    Button {
        id: button
        x: 23
        y: 63
        text: qsTr("Button")
        onClicked: nowPlaying.load("file:///media/gino/Gino HDD/music/Breaks/VA-Breaks_Beats__Bass-WEB-2015-iHR/00-va-breaks_beats__bass-web-2015.m3u");
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        onAccepted: {
            //mediaplayer.source = fileDialog.fileUrls[0]
            nowPlaying.load(fileDialog.fileUrls[0])
        }
        onRejected: {
            console.log("Canceled")
        }
    }

    Playlist{
        id: nowPlaying
    }



    MediaPlayer {
        id: mediaplayer
        source: "file:///media/gino/Gino HDD/music/Trap/VA_-_All_Trap_Music_Vol_3-WEB-2014-BiLDERBERG/14-massappeals_-_im_good.mp3"
        playlist: nowPlaying
        onPaused: {
            playButton.source = "qrc:/qml/icons/play.png";
        }
        onStopped: {
            playButton.source = "qrc:/qml/icons/play.png";
        }
        onPlaying: {
            playButton.source = "qrc:/qml/icons/pause.png";
        }
    }





}
