import QtQuick 2.5
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.0

Item {
    id: __cclayout
    anchors.fill: parent
    property int left_seat_heat_rate : 0
    property int right_seat_heat_rate : 0
    
    Item {
        id: item4
        anchors.bottomMargin: parent.height * 0.15
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        
        
        RowLayout {
            id: top_buttons
            anchors.right: parent.right
            anchors.left: parent.left
            
            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
            
            Rectangle {
                height: width/7
                color: "#33ffffff"
                radius: height/2
                Layout.fillWidth: false
                Layout.fillHeight: false
                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                border.width: 0
                width: parent.width * 0.7
                
                RowLayout {
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.bottom: parent.bottom
                    anchors.top: parent.top

                    
                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }
                    
                    TopButton {
                        id: button_rear_defrost
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        imageSrc: "qrc:/qml/icons/svg/rear-window-defrost.svg"
                    }
                    
                    TopButton {
                        id: button_defrost
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        imageSrc: "qrc:/qml/icons/svg/windshield-defrost.svg"
                    }
                    
                    TopButton {
                        id: button_ac
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        imageSrc: "qrc:/qml/icons/svg/air-conditioning.svg"
                    }
                    
                    TopButton {
                        id: button_recirc
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        imageSrc: "qrc:/qml/icons/svg/recirculation.svg"
                    }
                    
                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }
                    
                }
            }
            
            
            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
        
        RowLayout {
            id: fan_direction
            height: parent.height *0.6
            anchors.top: top_buttons.bottom
            anchors.topMargin: 0
            spacing: 0
            anchors.right: parent.right
            anchors.left: parent.left
            
            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true

                FanDirection {
                    width:height
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                }
            }
        }

        FanSlider {
            id: fanslider
            anchors.top: fan_direction.bottom
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            Layout.fillHeight: false
            Layout.fillWidth: true
        }
    }

    Rectangle {
        id:overlay
        color: "#4c000000"
        visible: false
        anchors.fill: parent

        MouseArea {
            anchors.fill: parent
            onClicked: {
                overlay.visible = false
                left_tempslider.visible = false
                right_tempslider.visible = false
                fanslider.slider_enabled = true
            }
        }
    }

    Item {
        id: bottom
        height: parent.height * 0.15
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0

        Rectangle {
            color: "#212121"
            anchors.fill: parent
        }

        RowLayout {
            spacing: 0
            anchors.fill: parent



            Item {
                id: item1
                Layout.fillHeight: true
                Layout.fillWidth: true



                Text {
                    id: front_temp
                    color: "#ffffff"                    
                    text: qsTr(left_tempslider.sliderValue.toString())
                    font.family: "Tahoma"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: parent.height*0.6
                }


                Text {
                    color: "#ffffff"
                    text: qsTr("°C")
                    anchors.top: front_temp.top
                    anchors.topMargin: 0
                    anchors.left: front_temp.right
                    anchors.leftMargin: 0
                    font.pixelSize: parent.height*0.2
                }


                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        left_tempslider.visible = !left_tempslider.visible
                        overlay.visible = right_tempslider.visible?true:overlay.visible?false:true
                        fanslider.slider_enabled = !overlay.visible
                        right_tempslider.visible = false
                    }
                }

                TempSlider {
                    id:left_tempslider
                    height: __cclayout.height * 0.85
                    visible: false
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.bottom: parent.top
                    anchors.bottomMargin: 0
                    side:"left"
                }
            }

            Item {
                id: item2
                Layout.fillWidth: true
                Layout.fillHeight: true


                Image {
                    id:left_seat_icon
                    anchors.bottom: left_seat_heat.top
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottomMargin: 0
                    fillMode: Image.PreserveAspectFit
                    source: "qrc:/qml/icons/svg/seat-heat.svg"
                }

                ColorOverlay {
                    id: left_seat_overaly
                    color: "#ff5722"
                    anchors.fill: left_seat_icon
                    visible: left_seat_heat_rate >= 1?true:false
                    enabled: true
                    source: left_seat_icon
                }

                RowLayout {
                    id: left_seat_heat
                    height: parent.height * 0.2
                    spacing: 5
                    width: parent.width * 0.4
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0

                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Rectangle {
                            id: left1
                            width: parent.height *0.7
                            height: parent.height *0.7
                            radius: height/2
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            Layout.fillHeight: false
                            Layout.fillWidth: false
                            color:left_seat_heat_rate >= 1?"#ff5722":"#FFFFFF"
                        }
                    }


                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Rectangle {
                            id: left2
                            width: parent.height *0.7
                            height: parent.height *0.7
                            radius: height/2
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            Layout.fillHeight: false
                            Layout.fillWidth: false
                            color:left_seat_heat_rate >= 2?"#ff5722":"#FFFFFF"
                        }
                    }

                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Rectangle {
                            id: left3
                            x: 0
                            y: 4
                            width: parent.height *0.7
                            height: parent.height *0.7
                            radius: height/2
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            Layout.fillHeight: false
                            Layout.fillWidth: false
                            color:left_seat_heat_rate >= 3?"#ff5722":"#FFFFFF"
                        }
                    }

                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: left_seat_heat_rate == 3?left_seat_heat_rate = 0:left_seat_heat_rate++
                }
            }




            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }


            Item {
                id: item3
                Layout.fillWidth: true
                Layout.fillHeight: true

                Image {
                    id:right_seat_icon
                    anchors.left: parent.left
                    anchors.bottomMargin: 0
                    fillMode: Image.PreserveAspectFit
                    anchors.bottom: right_seat_heat.top
                    anchors.top: parent.top
                    anchors.right: parent.right
                    source: "qrc:/qml/icons/svg/seat-heat.svg"
                }

                ColorOverlay {
                    id: right_seat_overaly
                    color: "#ff5722"
                    anchors.fill: right_seat_icon
                    visible: right_seat_heat_rate >= 1?true:false
                    enabled: true
                    source: right_seat_icon
                }

                RowLayout {
                    id: right_seat_heat
                    width: parent.width * 0.4
                    height: parent.height * 0.2
                    anchors.bottomMargin: 0
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Rectangle {
                            id: right1
                            width: parent.height *0.7
                            height: parent.height *0.7
                            color: right_seat_heat_rate >= 1?"#ff5722":"#FFFFFF"
                            radius: height/2
                            Layout.fillHeight: false
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            Layout.fillWidth: false
                        }
                    }

                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Rectangle {
                            id: right2
                            width: parent.height *0.7
                            height: parent.height *0.7
                            color: right_seat_heat_rate >= 2?"#ff5722":"#FFFFFF"
                            radius: height/2
                            Layout.fillHeight: false
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            Layout.fillWidth: false
                        }
                    }

                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Rectangle {
                            id: right3
                            width: parent.height *0.7
                            height: parent.height *0.7
                            color: right_seat_heat_rate >= 3?"#ff5722":"#FFFFFF"
                            radius: height/2
                            Layout.fillHeight: false
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            Layout.fillWidth: false
                        }
                    }
                }

                MouseArea {
                    x: 86
                    y: 108
                    anchors.fill: parent
                    onClicked: right_seat_heat_rate == 3?right_seat_heat_rate = 0:right_seat_heat_rate++
                }
            }

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Text {
                    id: back_temp
                    color: "#ffffff"
                    text: qsTr(right_tempslider.sliderValue.toString())
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: "Tahoma"
                    font.pixelSize: parent.height*0.6
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    color: "#ffffff"
                    text: qsTr("°C")
                    anchors.leftMargin: 0
                    anchors.topMargin: 0
                    font.pixelSize: parent.height*0.2
                    anchors.left: back_temp.right
                    anchors.top: back_temp.top
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        right_tempslider.visible = !right_tempslider.visible
                        overlay.visible = left_tempslider.visible?true:overlay.visible?false:true
                        fanslider.slider_enabled = !overlay.visible
                        left_tempslider.visible = false
                    }
                }

                TempSlider {
                    id:right_tempslider
                    height: __cclayout.height * 0.85
                    visible: false
                    anchors.leftMargin: 0
                    anchors.left: parent.left
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 0
                    anchors.right: parent.right
                    anchors.bottom: parent.top
                    side:"right"
                }
            }
        }
    }

}
