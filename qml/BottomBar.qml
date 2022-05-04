import QtQuick 2.14
import QtQml.Models 2.15
import QtQuick.Layouts 1.15

import HUDPlugins 1.0

Rectangle {
    id: __root

    color: "#212121"
    DropArea {
        anchors.fill: parent
        onEntered: {
            if (drag.source.visualIndex === undefined) {
                drag.source.disableMouseArea()
                BottomBarModel.insertPluginItem(0, drag.source.name)
            }
        }
    }
    RowLayout {
        id:bottomRow

        signal itemEnteredDropArea()
        anchors.fill: parent

        Repeater {
            id: repeater

            model: DelegateModel {
                id: visualModel
                model: BottomBarModel
                delegate: Item {
                    id: delegateRoot
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    //                    Layout.maximumWidth: fillSpace ? undefined : height * 1.5
                    Layout.maximumWidth: fillSpace ? bottomRow.width : height


                    DropArea {
                        id:dropArea
                        anchors.fill: parent

                        onEntered: {
                            if (drag.source.visualIndex !== undefined) {
                                visualModel.items.move(drag.source.visualIndex,
                                                       delegateRoot.DelegateModel.itemsIndex)
                            } else {
                                drag.source.disableMouseArea()
                                BottomBarModel.insertPluginItem(delegateRoot.DelegateModel.itemsIndex, drag.source.name)
                            }
                        }
                    }

                    Item {
                        id: draggable
                        property int visualIndex: delegateRoot.DelegateModel.itemsIndex
                        property int indexFrom : 0

                        width: delegateRoot.width
                        height: delegateRoot.height

                        Loader {
                            id:loader
                            height: parent.height
                            width: parent.width
                            anchors.horizontalCenter: parent.horizontalCenter

                        }
                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            drag.target: draggable
                            onReleased: parent.Drag.drop()
                            enabled:BottomBarModel.editing
                        }
                        Component.onCompleted: {
                            loader.setSource(source, properties)
                        }

                        Drag.active: mouseArea.drag.active
                        Drag.hotSpot.x: draggable.width / 2
                        Drag.hotSpot.y: draggable.height / 2
                        property bool dragActive: mouseArea.drag.active
                        onDragActiveChanged: {
                            if(dragActive) { //
                                indexFrom = visualIndex
                            } else {
                                BottomBarModel.move(indexFrom,
                                                    visualIndex)
                            }
                        }

                        states: [
                            State {
                                when: mouseArea.drag.active
                                ParentChange {
                                    target: draggable
                                    parent: __root
                                }
                            }
                        ]
                    }
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;height:80;width:600}
}
##^##*/
