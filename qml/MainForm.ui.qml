import QtQuick 2.5

Rectangle {

    width: 800
    height: 480

    Image {
        id: image1
        x: 0
        y: 60
        width: 700
        height: 420
        fillMode: Image.PreserveAspectFit
        source: "../Headunit/MyHyundai_AA_google_cards.0.jpg"
    }

    Rectangle {
        id: rectangle1
        x: 700
        y: 0
        width: 100
        height: 480
        color: "#233239"

        Rectangle {
            id: item1
            x: 5
            y: 385
            width: 90
            height: 90
            color:"#ff00ff"

            Image {
                id: image2
                x: 0
                y: 0
                width: 90
                height: 90
                fillMode: Image.PreserveAspectFit
                source: "icons/thermometer.png"
            }
        }
    }
}
