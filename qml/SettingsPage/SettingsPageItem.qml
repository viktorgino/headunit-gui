import QtQuick 2.11
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0

import HUDTheme 1.0

Item {
    id: __root
    height: visible?60:0
    //width: parent.width
    property alias leftPadding: __wrapper.width
    property var itemData : {
                "label":"",
                "name": "",
                "description": "",
                "iconImage":"",
                "autosave": false,
                "conditional":false,
                "conditionTarget": "",
                "conditionValue":true
    }
    property var value : ""
    property var conditionValue: ""
    property bool parentVisible: true
    signal push(var qml, var properties)

    Connections{
        id:listReadyConnection
        enabled:false
        ignoreUnknownSignals: true
        target : parent.parent.parent
        onListReady: {
            var parentCondition = parent.parent.parent.contentItem.children
            for(var item in parentCondition){
                if(typeof parentCondition[item].item === "undefined")
                    continue;

                if(parentCondition[item].item.itemData.name === itemData.conditionTarget){
                    __root.parentVisible = parentCondition[item].item.visible
                    __root.conditionValue = parentCondition[item].item.value
                    conditionalChainConnection.target = parentCondition[item].item
                    conditionalChainConnection.enabled = true
                    break;
                }
            }
        }
    }

    Connections{
        id:conditionalChainConnection
        enabled:false
        ignoreUnknownSignals: true
        onVisibleChanged: {
            __root.parentVisible = target.visible
        }
        onValueChanged: {
            conditionValue = target.value
        }
    }

    onItemDataChanged : {
        if(itemData.conditional === true){
            if(typeof parent.parent.parent.listReady === "function"){
                listReadyConnection.enabled = true;
            }
        }
    }

    visible: {
        if(!itemData.conditional)
            return true;

        return (__root.conditionValue === itemData.conditionValue) && parentVisible;
    }

    Item {
        id:__wrapper
        width: subtitle.width>title.width?itemIcon.width+subtitle.width:itemIcon.width+title.width
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0

        ThemeFormText {
            id: subtitle
            height: subtitle.text===""?0:30
            text: typeof(itemData.description)==="undefined"?"":itemData.description
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.left: itemIcon.right
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            subtext: true
        }

        ThemeFormText {
            id: title
            height: subtitle.text===""?60:30
            text: itemData.label
            anchors.leftMargin: 0
            verticalAlignment: subtitle.text===""?Text.AlignVCenter:Text.AlignBottom
            horizontalAlignment: Text.AlignLeft
            anchors.top: parent.top
            anchors.left: itemIcon.right
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        }

        SettingsPageItemIcon {
            id:itemIcon
            iconImage: typeof(itemData.iconImage)==="undefined"?"":itemData.iconImage
        }
    }

}
