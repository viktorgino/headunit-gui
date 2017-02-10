import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1

Item {
    id: __media_container_list
    clip: true
    property var model
    property url icon
    property string name
    property string item_type
    property var letters : []
    signal itemClicked(var itemData)
    onModelChanged: {
        letters = [];
        if(model.length > 0){
            for(var item in model){
                var letter = model[item]["name"].substring(0, 1);
                if(!letters.hasOwnProperty(letter)){
                    letters[letter] = item;
                }
            }
        }
    }

    ListView {
        id: listView
        anchors.rightMargin: 0
        boundsBehavior: Flickable.DragOverBounds
        clip: true
        anchors.top: header.bottom
        anchors.right: scroll_bar.left
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.topMargin: 0
        model: parent.model
        delegate: switch(item_type){
                  case "folders":
                      media_folder_list_item
                      break;
                  default:
                      media_container_list_item
                      break;
                  }

        Component{
            id:media_container_list_item
            MediaContainerListItem {
                onItemClicked: {
                    itemData.item_type = __media_container_list.item_type;
                    __media_container_list.itemClicked(itemData)
                }
            }
        }
        Component{
            id:media_folder_list_item
            MediaFolderListItem {
                onItemClicked: {
                    itemData.item_type = __media_container_list.item_type;
                    __media_container_list.itemClicked(itemData)
                }
            }
        }

    }

    Item {
        id: header
        height: parent.height * 0.15
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        Rectangle {
            id: rectangle
            color: "#424242"
            anchors.fill: parent
        }

        Image {
            id: image
            width: height
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 10
            source: __media_container_list.icon
            mipmap:true
        }

        Text {
            id: text1
            color: "#ffffff"
            text: qsTr(__media_container_list.name)
            anchors.left: image.right
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 16
        }
    }

    Item{
        id: scroll_bar
        width: 20
        anchors.top: header.bottom
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        Rectangle{
            opacity: 0.5
            property var alphabet : "...,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z".split(",");
            height: parent.height/alphabet.length
            width:20
            radius: 10
            id: scroller
            property int current_indx: 10
            onYChanged: {
            }
        }

        ColumnLayout {
            anchors.fill: parent
            id:scroll_column
            Repeater{
                model:scroller.alphabet
                id:scroll_repeater
                Text{
                    Layout.fillHeight: true
                    property int indx: index
                    x : {
                        var diff;
                        if(index > scroller.current_indx){
                            diff = scroller.current_indx - index
                        } else if(index === scroller.current_indx) {
                            diff = 0;
                        } else {
                            diff =  scroller.current_indx - index
                        }
                        if(diff > 7 || diff < -7){
                            return 0;
                        } else {
                            var angle = 0- (90/7 * diff);
                            var ret =  scroller.x * Math.cos(angle*(Math.PI / 180))
                            //console.log("Letter : "+scroller.alphabet[index]+" | Diff : " + diff +" | Angle : " + angle + " | ret: " + ret + " | scroller.x: " + scroller.x);
                            return ret;
                        }
                    }
                    text:scroller.alphabet[index]
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignTop
                    color:"white"
                }
            }
        }
        MouseArea {
            anchors.fill: parent
            propagateComposedEvents: false
            preventStealing: false
            property bool isMouseDown: false
            function getIndex(y){
                return Math.floor(y/(scroll_column.height / scroller.alphabet.length));
            }

            onPressed: {
                isMouseDown=true;
                scroller.y=mouse.y-10
                scroller.current_indx = getIndex(mouse.y);
                var letter = scroller.alphabet[scroller.current_indx];
                if(typeof(letter) === "undefined")
                    listView.positionViewAtIndex(0,ListView.Beginning);
                else
                    listView.positionViewAtIndex(__media_container_list.letters[scroller.alphabet[scroller.current_indx]],ListView.Beginning);
            }
            onReleased: {
                isMouseDown=false;
                scroller.x=0
            }
            onCanceled: {
                isMouseDown=false;
            }
            onPositionChanged: {
                if(mouse.y <= scroll_bar.height & mouse.y >= 0){
                    scroller.y=mouse.y
                    var letter = scroller.alphabet[scroller.current_indx];
                    if(typeof(letter) === "undefined")
                        listView.positionViewAtIndex(0,ListView.Beginning);
                    else
                        listView.positionViewAtIndex(__media_container_list.letters[scroller.alphabet[scroller.current_indx]],ListView.Beginning);
                }
                if(mouse.x >= -100 & mouse.x <= 0){
                    scroller.x=mouse.x
                }
                scroller.current_indx = getIndex(mouse.y);
            }
            onClicked: {
            }
        }
    }

}
