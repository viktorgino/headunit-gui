import QtQuick 2.0

Item {
    id:__media_list
    property var model;
    signal itemClicked(string path)
    ListView {
        id: listView
        anchors.fill: parent
        model: __media_list.model
        delegate: MediaListItem{
            onItemClicked: __media_list.itemClicked(path)
        }
    }

}
