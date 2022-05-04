import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQml.Models 2.15

import HUDHelper 1.0

QMapModel {
    id:__root
    property bool editing : false
    property var menuItems : [{
            "name": "themeTestOverlay1",
            "label": "Theme Test Overlay 1",
            "source" : "../designer/content/BottomBarTestItem.qml",
        }, {
            "name": "themeTestOverlay2",
            "label": "Theme Test Overlay 2",
            "source" : "../designer/content/BottomBarTestItem.qml",
        }, {
            "name": "themeTestOverlay3",
            "label": "Theme Test Overlay 3",
            "source" : "../designer/content/BottomBarTestItem.qml",
        }, {
            "name": "themeTestOverlay4",
            "label": "Theme Test Overlay 4",
            "source" : "../designer/content/BottomBarTestItem.qml",
        }, {
            "name": "themePluginOverlay1",
            "label": "Theme Overlay 1",
            "source" : "../designer/content/BottomBarTestItem.qml",
        }, {
            "name": "themePluginOverlay2",
            "label": "Theme Overlay 2",
            "source" : "../designer/content/BottomBarTestItem.qml",
        }, {
            "name": "themePluginOverlay13",
            "label": "Theme Overlay 3",
            "source" : "../designer/content/BottomBarTestItem.qml",
        }, {
            "name": "themePluginOverlay14",
            "label": "Theme Overlay 4",
            "source" : "../designer/content/BottomBarTestItem.qml",
        }, {
            "name": "samplePluginOverlay1",
            "label": "Sample Plugin Overlay 1",
            "source" : "../designer/content/BottomBarTestItem.qml",
        }, {
            "name": "samplePluginOverlay2",
            "label": "Sample Plugin Overlay 2",
            "source" : "../designer/content/BottomBarTestItem.qml",
        }, {
            "name": "samplePluginOverlay3",
            "label": "Sample PluginOverlay 3",
            "source" : "../designer/content/BottomBarTestItem.qml",
        }, {
            "name": "samplePluginOverlay4",
            "label": "Sample Plugin Overlay 4",
            "source" : "../designer/content/BottomBarTestItem.qml",
        }]
    model: {
        "roles": ["name", "label", "source", "contextProperty", "properties", "fillSpace"],
        "data": [
                    {
                        "name" : "testItem1",
                        "label" : "Test Item 1",
                        "source" : "../designer/content/BottomBarTestItem.qml",
                        "contextProperty" : "",
                        "properties":{}
                    },
                    {
                        "name" : "testItem2",
                        "label" : "Test Item 2",
                        "source" : "../designer/content/BottomBarTestItem.qml",
                        "contextProperty" : "",
                        "properties":{}
                    },
                    {
                        "name" : "testItem3",
                        "label" : "Test Item 3",
                        "source" : "../designer/content/BottomBarTestItem.qml",
                        "contextProperty" : "",
                        "properties":{}
                    },
                    {
                        "name" : "testItem4",
                        "label" : "Test Item 4",
                        "source" : "BottomBarSpacer.qml",
                        "contextProperty" : "",
                        "properties":{},
                        "fillSpace" : true
                    },
                    {
                        "name" : "testItem5",
                        "label" : "Test Item 5",
                        "source" : "../designer/content/BottomBarTestItem.qml",
                        "contextProperty" : "",
                        "properties":{}
                    },
                    {
                        "name" : "testItem6",
                        "label" : "Test Item 6",
                        "source" : "../designer/content/BottomBarTestItem.qml",
                        "contextProperty" : "",
                        "properties":{}
                    },
                    {
                        "name" : "testItem7",
                        "label" : "Test Item 7",
                        "source" : "../designer/content/BottomBarTestItem.qml",
                        "contextProperty" : "",
                        "properties":{}
                    }
                ]
    }
    function insertPluginItem (position, name) {
        console.log("insertPluginItem : ", position, name)
        for (var x in menuItems) {
            var item = menuItems[x]
            if(item.name === name ){
                item["properties"] = {"label" : item.label}
                item["contextProperty"] = {}
                var newModel = model
                newModel.data.splice(position, 0, item)
                model = newModel
            }
        }
    }
    function move (from, to) {
        var newModel = model
        var itemRemoved = newModel.data.splice(from, 1)
        newModel.data.splice(to, 0, itemRemoved[0])
        model = newModel
    }
} //NameRole = Qt::UserRole + 1,//LabelRole,//IconRole,//QmlSourceRole,//LoadedRole,//SettingsRole,//SettingsItemsRole

