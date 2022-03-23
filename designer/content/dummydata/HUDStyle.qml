import QtQuick 2.0

QtObject {
    property var colors : {
        "text": "#ffffff",
        "subText": "#CACACA",
        "headingText1": "#ffffff",
        "headingText2": "#ffffff",
        "headingText3": "#ffffff",
        "headingText4":"#ffffff",
        "headingText5": "#ffffff",
        "icon": "#ffffff",
        "iconActive": "#ff5722",
        "box": "#212121",
        "formBox": "#3f51b5",
        "formText": "#ffffff",
        "formSubText": "#aaaaaa",
        "formBackground": "#80000000",
        "formPopupBackground": "#646464"
    }

    property var sizes : {
        "text": 11,
        "subText": 10,
        "headingText1": 12,
        "headingText2": 14,
        "headingText3": 16,
        "headingText4": 18,
        "headingText5": 20,
        "formText": 11,
        "formSubText": 10,
        "menuText": 10,
        "menuIcon": 30,
        "bottomBarHeight": 100
    }

    property QtObject background : QtObject{
        property string objectName : ""
        property string color: "#ffffff"
        property bool image: true
        property string imagePath: "backgrounds/micah-hallahan-14075-unsplash.jpg"
        property bool slideshow: false
        property string slideshowPath: ""
        property int slideshowTime: 0

    }

    property var themeSettings : {
        "objectName": "",
        "font": "Raleway"
    }
}

