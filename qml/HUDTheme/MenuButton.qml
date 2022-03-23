import QtQuick 2.0

Item {
    id:__root
    property bool isActive: false
    property var color : HUDStyle.colors.icon
    Item {
        id: item1
        width: __root.width
        height: __root.height *0.1

        Rectangle {
            id: rectangle1
            width: __root.width
            height: __root.height *0.1
            color: __root.color
        }
    }


    Item {
        id: item2
        width: __root.width
        height: __root.height *0.1
        y:__root.height-height
        Rectangle {
            id: rectangle3
            width: __root.width
            height: __root.height *0.1
            color: __root.color
        }
    }

    states: [
        State {
            name: "Active"
            when: __root.isActive

            PropertyChanges {
                target: rectangle2
                x: __root.width*0.1
                width: __root.width*0.90
                rotation: 180
            }

            PropertyChanges {
                target: rectangle1
                x: 0
                y: parent.height/2-height/2
                width: __root.width*0.4
            }

            PropertyChanges {
                target: rectangle3
                x: 0
                y: parent.height/2-height/2
                width: __root.width*0.4
            }

            PropertyChanges {
                target: item1
                x: 0
                y: __root.height/2 + Math.sqrt(Math.pow(height/2+rectangle3.height/2,2)/2) - Math.sqrt(2*Math.pow(height,2)) + (Math.sqrt(2*Math.pow(height,2))-height)/2
                width: __root.width*0.4
                height: __root.width*0.4
                rotation: -45
            }

            PropertyChanges {
                target: item2
                x: 0
                width: __root.width*0.4
                height: __root.width*0.4
                rotation: 45
                y:__root.height/2 - Math.sqrt(Math.pow(height/2+rectangle3.height/2,2)/2) + (Math.sqrt(2*Math.pow(height,2))-height)/2
            }
        }
    ]

    Rectangle {
        id: rectangle2
        x: 0
        y: __root.height/2 - height/2
        width: __root.width
        height: __root.height *0.1
        color: __root.color
    }

    transitions: Transition {
        NumberAnimation { properties: "x,y,rotation,height,width"; duration: 250}
    }

}
