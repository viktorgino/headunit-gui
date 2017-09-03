import QtQml 2.2
import QtQuick 2.5
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0
import QtBluetooth 5.7

Item {
    id:__root
    property int fontSize: 11
    anchors.fill: parent
    height: 121 + devices.count * 40
    ColumnLayout{
        anchors.fill: parent
        Item{
            Layout.fillWidth: true
            height:40
            Text{
                font.pointSize: 11
                anchors.left: parent.left
                anchors.leftMargin: 8
                text: "Bluetooth"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            Switch {
                id:btPowerSwitch
                checked: telephonyManager.btConnectionState > 0
                anchors.right: parent.right
                anchors.rightMargin: 0
                onCheckedChanged: {
                    telephonyManager.btConnectionState = telephonyManager.btConnectionState===0?1:0
                    if(checked)
                        btModel.running = true
                }
            }
        }
        Item{
            Layout.fillWidth: true
            height:40
            Text{
                font.pointSize: 11
                anchors.right: parent.right
                anchors.rightMargin: 8
                anchors.left: parent.left
                anchors.leftMargin: 8
                text: "Visible"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            Switch {
                id:btVisibilitySwitch
                checked: telephonyManager.btConnectionState == 2
                anchors.right: parent.right
                anchors.rightMargin: 0
                onCheckedChanged: {
                    telephonyManager.btConnectionState = checked?2:1
                    btModel.running = true
                }
            }
        }
        Item{
            Layout.fillWidth: true
            height:41
            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: "#1E000000"
                anchors.right: parent.right
                anchors.rightMargin: 8
                anchors.left: parent.left
                anchors.leftMargin: 8
            }
            Text{
                Layout.fillWidth: true
                height:40
                font.pointSize: 11
                anchors.right: parent.right
                anchors.rightMargin: 8
                anchors.left: parent.left
                anchors.leftMargin: 8
                text: "Paired Devices"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }
        Repeater {
            id:devices
            //model:telephonyManager.connectedDevices
            model:btModel
            Item{
                id: item3
                Layout.fillWidth: true
                height:40
                Text {
                    font.pointSize: 11
                    text: deviceName
                    anchors.right: parent.right
                    anchors.rightMargin: 8
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                }

                Switch {
                    anchors.verticalCenter: parent.verticalCenter
                    checked: modelData.connected
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                }
            }
        }
    }


    BluetoothDiscoveryModel {
        id: btModel
        running: true
        discoveryMode: BluetoothDiscoveryModel.DeviceDiscovery
        //onDiscoveryModeChanged: console.log("Discovery mode: " + discoveryMode)
        //onServiceDiscovered: console.log("Found new service " + service.deviceAddress + " " + service.deviceName + " " + service.serviceName);
        onDeviceDiscovered: console.log("New device: " + device)
        onErrorChanged: {
            switch (btModel.error) {
            case BluetoothDiscoveryModel.PoweredOffError:
                console.log("Error: Bluetooth device not turned on"); break;
            case BluetoothDiscoveryModel.InputOutputError:
                console.log("Error: Bluetooth I/O Error"); break;
            case BluetoothDiscoveryModel.InvalidBluetoothAdapterError:
                console.log("Error: Invalid Bluetooth Adapter Error"); break;
            case BluetoothDiscoveryModel.NoError:
                break;
            default:
                console.log("Error: Unknown Error"); break;
            }
        }
    }
}
