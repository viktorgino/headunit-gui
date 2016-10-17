import QtQuick 2.5
import QtGraphicalEffects 1.0
import "ClimateControl"

Item {
    id: item188

    LinearGradient {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#36464e"
            }

            GradientStop {
                position: 1
                color: "#172027"
            }
        }
        end: Qt.point(200, 300)
        start: Qt.point(0, 0)
    }
    Loader {
        id: widgetLoader
        source: "qrc:/qml/Radio/RadioLayout.qml"
        asynchronous: false
        anchors.rightMargin: 0
        anchors.right: rightMenu.left
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.top: parent.top

        OpacityAnimator on opacity{
            duration: 2000
            easing.type: Easing.InOutQuad
            from: 0
            to: 1
        }
    }

    RightMenu {
        id: rightMenu
        width: height/5
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        onItemChanged:widgetLoader.source = source
    }

}
