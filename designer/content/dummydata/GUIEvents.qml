import QtQuick 2.0

QtObject {
    signal notificationReceived(var notification)
    signal openOverlay(var settings, var contextProperty, var source, var properties)
    signal closeOverlay

    function emitNotificationReceived(notification) {
        notificationReceived(notification)
    }
    function emitOpenOverlay(settings, contextProperty, source, properties) {
        openOverlay(settings, contextProperty, source, properties)
    }
    function emitCloseOverlay() {
        closeOverlay()
    }
}
