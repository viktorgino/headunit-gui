import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import HUDTheme 1.0
import HUDPlugins 1.0

Item {
    id: __root
    signal close()

    Rectangle {
        id: rectangle
        color: "#cc000000"
        anchors.fill: parent

        DropArea {
            anchors.fill: parent
            property int removeIndex : 0
            onDropped: {
                if (drag.source.visualIndex !== undefined) {
                    removeIndex = drag.source.visualIndex
                    BottomBarModel.remove(drag.source.visualIndex)
                    __root.state = ""
                }
            }
            onEntered: {
                if (drag.source.visualIndex !== undefined) {
                    __root.state = "removeHover"
                }
            }
            onExited: {
                __root.state = ""
            }
        }
        Item {
            id: removeItemsWrapper
            visible: false
            anchors.fill: parent
            anchors.rightMargin: 8
            anchors.leftMargin: 8
            anchors.bottomMargin: 8
            anchors.topMargin: 8
            Canvas {
                id: removeBoxBorder
                anchors.fill: parent
                onPaint:{
                    var ctx = getContext("2d");
                    ctx.setLineDash([5, 15]);
                    ctx.beginPath();
                    ctx.rect(0, 0, width, height);
                    ctx.strokeStyle = '#ffffff';
                    ctx.stroke();
                }
            }

            ImageIcon {
                id: removeIcon
                width: height
                height: parent.height * 0.8
                source: "image://icons/trash-b"
                anchors.horizontalCenter: parent.horizontalCenter
                color : "#ffffff"
                anchors.verticalCenter: parent.verticalCenter
            }

            ThemeText {
                id: removeText
                text: qsTr("Drop to remove item")

                anchors.top: removeIcon.bottom
                anchors.topMargin: 8
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        ListView {
            id: listView1
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: arrowWrapper.top
            anchors.bottomMargin: 8
            anchors.rightMargin: 8
            anchors.leftMargin: 8
            anchors.topMargin: 8
            clip: true

            ScrollBar.vertical: ThemeScrollBar {}
            model: PluginListModel {
                plugins: HUDPlugins
                listType: "BottomBar"
            }
            delegate: Item {
                id: item1
                width: listView1.width
                height: 100
                property var itemList : grid
                ThemeHeaderText {
                    id: itemLabel
                    text: label
                    anchors.left: parent.left
                    anchors.right: parent.right
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 0
                    level : 1
                    height: 40
                }

                ListView {
                    id: grid
                    width: listView1.width
                    anchors.top: itemLabel.bottom
                    orientation: ListView.Horizontal
                    height: 60
                    spacing: 10

                    ScrollBar.horizontal: ThemeScrollBar {
                        orientation: Qt.Horizontal
                    }

                    model: bottomBarItems
                    delegate: Item {
                        id:delegateRoot
                        width: 60
                        height: 60

                        Rectangle {
                            id: rectangle2
                            radius: 2
                            width: delegateRoot.width
                            height: delegateRoot.height
                            color: "#ffffff"
                            property string name : modelData.name
                            function disableMouseArea() {
                                rectangle2.dragActive = false
                            }

                            Text {
                                text: modelData.label
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.WordWrap
                                fontSizeMode: Text.Fit
                                minimumPointSize: 2
                            }
                            MouseArea {
                                id: mouseArea
                                anchors.fill: parent
                                drag.target: parent.dragActive ? parent : undefined
                                onReleased: {
                                    rectangle2.dragActive = false
                                    rectangle2.visible = true
                                }
                                onPressed: {
                                    parent.dragActive = true
                                }
                                drag.onActiveChanged: {
                                    if(!active){
                                        rectangle2.visible = true
                                    }

                                }
                            }

                            property bool dragActive : false
                            Drag.active: mouseArea.drag.active
                            Drag.hotSpot.x: rectangle2.width / 2
                            Drag.hotSpot.y: rectangle2.height / 2

                            states: [
                                State {
                                    when: mouseArea.drag.active
                                    ParentChange {
                                        target: rectangle2
                                        parent: rectangle
                                    }
                                }
                            ]
                        }
                    }
                }
            }
        }

        Item {
            id: arrowWrapper
            height: 35
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 8
            anchors.bottomMargin: 8
            anchors.leftMargin: 8

            ImageIcon {
                id: leftArrow
                width: 20
                height: 20
                color: "#ffffff"
                anchors.verticalCenter: arrowLine.verticalCenter
                source: "image://icons/arrow-left-b"
            }

            Rectangle {
                id: arrowLine
                height: 1
                color: "#ffffff"
                anchors.left: leftArrow.right
                anchors.right: rightArrow.left
                anchors.bottom: parent.bottom
                anchors.rightMargin: -8
                anchors.leftMargin: -8
                anchors.bottomMargin: 10
                anchors.verticalCenterOffset: 1
            }


            ImageIcon {
                id: rightArrow
                width: 20
                height: 20
                color: "#ffffff"
                anchors.verticalCenter: arrowLine.verticalCenter
                source: "image://icons/arrow-right-b"
                anchors.right: parent.right
                anchors.rightMargin: 8
            }


            ThemeFormText {
                id: arrowText
                text: qsTr("Drag items to rearrange")
                anchors.bottom: arrowLine.top
                anchors.bottomMargin: 4
                anchors.horizontalCenter: arrowLine.horizontalCenter
            }


        }

        ImageIcon {
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
    states: [
        State {
            name: "removeHover"

            PropertyChanges {
                target: removeItemsWrapper
                visible: true
            }

            PropertyChanges {
                target: arrowWrapper
                visible: false
            }

            PropertyChanges {
                target: listView1
                visible: false
            }
        }
    ]
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorColor:"#c0c0c0";height:480;width:640}
}
##^##*/

