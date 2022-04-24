import QtQuick 2.0

QtObject {
    signal notificationReceived(var notification)
    signal openOverlay(var source, var properties)
    signal closeOverlay

    function emitNotificationReceived(notification) {
        notificationReceived(notification)
    }
    function emitOpenOverlay(source, properties) {
        openOverlay(source, properties)
    }
    function emitCloseOverlay() {
        closeOverlay()
    }
}
