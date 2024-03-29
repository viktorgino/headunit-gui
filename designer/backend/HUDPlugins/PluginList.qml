import QtQuick 2.15
import QtQuick.Controls 2.15

QtObject{
    property QtObject sampleSettings: QtObject {
        property int slider: 18
        property int tumbler: 18
        property bool switch1: true
        property bool switch2: true
        property bool switch3: true
        property string textfield: "Qt"
        property int textfield2: 2
        property real textfield3: 2.5
        property string textfield4: "00ff00"
        property string textfield5: "127.0.0.1"
        property int combobox: 1
        property string combobox2: "value2"
        property string color: "#00fff0"
    }
    function callSlot(pluginName, slot) {

    }

    property QtObject dummySettings: QtObject {}
    property var pluginList: [
        {
            "name": "themeTest",
            "label": "Theme Test",
            "icon": "image://icons/android-book",
            "qmlSource": "../designer/content/ThemeTest.qml",
            "pluginLoaded": true,
            "settings": dummySettings,
            "contextProperty": {},
            "settingsMenu": {
                "items": []
            },
            "bottomBarItems": [{
                    "name": "themeTestOverlay1",
                    "label": "Theme Test Overlay 1",
                    "source": "qrc://overlay1"
                }, {
                    "name": "themeTestOverlay2",
                    "label": "Theme Test Overlay 2",
                    "source": "qrc://overlay2"
                }, {
                    "name": "themeTestOverlay3",
                    "label": "Theme Test Overlay 3",
                    "source": "qrc://overlay3"
                }, {
                    "name": "themeTestOverlay4",
                    "label": "Theme Test Overlay 4",
                    "source": "qrc://overlay4"
                }]
        }, {
            "name": "themePlugin",
            "label": "Theme",
            "icon": "image://icons/android-mixer",
            "qmlSource": "../designer/content/BottomBarTestItem.qml",
            "pluginLoaded": true,
            "settings": dummySettings,
            "contextProperty": {},
            "settingsMenu": {
                "type": "loader",
                "source": "SettingsPageTheme.qml"
            },
            "overlay": "BottomBarItems.qml",
            "bottomBarItems": [{
                    "name": "themePluginOverlay1",
                    "label": "Theme Overlay 1",
                    "source": "qrc://overlay1"
                }, {
                    "name": "themePluginOverlay2",
                    "label": "Theme Overlay 2",
                    "source": "qrc://overlay2"
                }, {
                    "name": "themePluginOverlay13",
                    "label": "Theme Overlay 3",
                    "source": "qrc://overlay3"
                }, {
                    "name": "themePluginOverlay14",
                    "label": "Theme Overlay 4",
                    "source": "qrc://overlay4"
                }]
        },
        {
            "name": "samplePlugin",
            "label": "Sample Plugin",
            "icon": "image://icons/android-hand",
            "qmlSource": "../designer/content/BottomBarTestItem.qml",
            "pluginLoaded": true,
            "settings": sampleSettings,
            "contextProperty": {},
            "bottomBarItems": [{
                    "name": "samplePluginOverlay1",
                    "label": "Sample Plugin Overlay 1",
                    "source": "qrc://overlay1"
                }, {
                    "name": "samplePluginOverlay2",
                    "label": "Sample Plugin Overlay 2",
                    "source": "qrc://overlay2"
                }, {
                    "name": "samplePluginOverlay3",
                    "label": "Sample PluginOverlay 3",
                    "source": "qrc://overlay3"
                }, {
                    "name": "samplePluginOverlay4",
                    "label": "Sample Plugin Overlay 4",
                    "source": "qrc://overlay4"
                }],
            "settingsMenu": {
                "type": "items",
                "description": "Settings Menu Test",
                "items": [{
                        "enableIcons": false,
                        "items": [{
                                "defaultValue": "#ffffff",
                                "description": "UI text color",
                                "label": "Colors",
                                "name": "text",
                                "type": "color"
                            }, {
                                "defaultValue": "#CACACA",
                                "description": "UI sub text color",
                                "label": "Sub Text",
                                "name": "subText",
                                "type": "color"
                            }],
                        "label": "Items (save on back)",
                        "name": "items2",
                        "type": "items"
                    }, {
                        "autoSave": true,
                        "enableIcons": false,
                        "items": [{
                                "defaultValue": "#ffffff",
                                "description": "UI text color",
                                "label": "Colors",
                                "name": "text",
                                "type": "color"
                            }, {
                                "defaultValue": "#CACACA",
                                "description": "UI sub text color",
                                "label": "Sub Text",
                                "name": "subText",
                                "type": "color"
                            }],
                        "label": "Items (autosave)",
                        "name": "items3",
                        "type": "items"
                    }, {
                        "label": "Loader",
                        "name": "loader",
                        "source": "qrc:/qml/SettingsPage/SettingsPageTheme.qml",
                        "type": "loader"
                    }, {
                        "label": "Text",
                        "name": "text",
                        "type": "text"
                    }, {
                        "defaultValue": 18,
                        "label": "Slider",
                        "maximum": 255,
                        "minimum": 5,
                        "name": "slider",
                        "prefix": "LS",
                        "stepSize": 1,
                        "suffix": "cm",
                        "type": "slider"
                    }, {
                        "defaultValue": 18,
                        "label": "Tumbler",
                        "maximum": 255,
                        "minimum": 5,
                        "name": "tumbler",
                        "prefix": "LS",
                        "stepSize": 1,
                        "suffix": "cm",
                        "type": "tumbler"
                    }, {
                        "label": "Switches",
                        "type": "header"
                    }, {
                        "defaultValue": true,
                        "label": "Switch",
                        "name": "switch1",
                        "textOff": "Off",
                        "textOn": "On",
                        "type": "switch"
                    }, {
                        "conditionTarget": "switch",
                        "conditionValue": true,
                        "conditional": true,
                        "defaultValue": true,
                        "label": "Optional Switch",
                        "name": "switch2",
                        "textOff": "Off",
                        "textOn": "On",
                        "type": "switch"
                    }, {
                        "conditionTarget": "switch2",
                        "conditionValue": true,
                        "conditional": true,
                        "defaultValue": true,
                        "label": "Optional Switch 2",
                        "name": "switch3",
                        "textOff": "Off",
                        "textOn": "On",
                        "type": "switch"
                    }, {
                        "conditionTarget": "switch3",
                        "conditionValue": true,
                        "conditional": true,
                        "label": "True",
                        "name": "text2",
                        "type": "text"
                    }, {
                        "conditionTarget": "switch3",
                        "conditionValue": false,
                        "conditional": true,
                        "label": "False",
                        "name": "text3",
                        "type": "text"
                    }, {
                        "label": "Textboxes",
                        "type": "header"
                    }, {
                        "defaultValue": "Qt",
                        "label": "Textfield (string)",
                        "name": "textfield",
                        "prefix": "Text:",
                        "suffix": "is awsome!",
                        "textType": "string",
                        "type": "textfield"
                    }, {
                        "defaultValue": 2,
                        "label": "Textfield (int)",
                        "name": "textfield2",
                        "prefix": "Number:",
                        "suffix": "apples",
                        "textType": "int",
                        "type": "textfield"
                    }, {
                        "defaultValue": 2.5,
                        "label": "Textfield (double)",
                        "name": "textfield3",
                        "prefix": "Double:",
                        "suffix": "kg",
                        "textType": "double",
                        "type": "textfield"
                    }, {
                        "defaultValue": "00ff00",
                        "label": "Textfield (regex)",
                        "name": "textfield4",
                        "prefix": "Regex:",
                        "regexp": "[0-9A-Fa-f]{6}",
                        "suffix": "hex",
                        "textType": "regexp",
                        "type": "textfield"
                    }, {
                        "defaultValue": "127.0.0.1",
                        "inputMask": "000.000.000.000;_",
                        "label": "Textfield (string, input mask)",
                        "name": "textfield5",
                        "textType": "regexp",
                        "type": "textfield"
                    }, {
                        "label": "",
                        "type": "header"
                    }, {
                        "label": "Checkbox",
                        "name": "checkbox",
                        "type": "checkbox"
                    }, {
                        "defaultValue": "0",
                        "description": "using an array as values",
                        "label": "Combo Box",
                        "name": "combobox",
                        "type": "combobox",
                        "values": ["Apple", "Orange", "Banana"]
                    }, {
                        "defaultValue": "value2",
                        "description": "using a map as values",
                        "label": "Combo Box",
                        "name": "combobox2",
                        "type": "combobox",
                        "values": {
                            "value1": "Apple",
                            "value2": "Orange",
                            "value3": "Banana"
                        }
                    }, {
                        "defaultValue": "#00fff0",
                        "description": "Color test",
                        "label": "Color",
                        "name": "color",
                        "type": "color"
                    }, {
                        "label": "Button",
                        "name": "button",
                        "type": "button",
                        "values": [{
                                "action": "console.log(\"Hello world!\")",
                                "label": "Click me!"
                            }, {
                                "action": "console.log(\"Hi!\")",
                                "label": "No, click me!"
                            }]
                    }, {
                        "browserType": "file",
                        "label": "File Select",
                        "name": "file",
                        "type": "file"
                    }, {
                        "browserType": "folder",
                        "label": "Folder Select",
                        "name": "folder",
                        "type": "file"
                    }, {
                        "action": "SamplePlugin.testNotification()",
                        "label": "Action",
                        "name": "action",
                        "type": "action"
                    }]
            }

        }
    ]

}
