#include "defaulttheme.h"

DefaultTheme::~DefaultTheme(){

}

void DefaultTheme::registerTypes(const char* /*uri*/)
{

    return;
}

void DefaultTheme::initializeEngine(QQmlEngine *engine, const char* /*uri*/)
{
        QQuickStyle::setStyle("Default");
        QQmlApplicationEngine * appEngine = static_cast<QQmlApplicationEngine* >(engine);
        if(!appEngine){
            qDebug() << "Engine is not a valid instance of QQmlApplicationEngine";
            return;
        }
        guiEvents = new GUIEvents();
        appEngine->rootContext()->setContextProperty("GUIEvents", guiEvents);
        appEngine->rootContext()->setContextObject(this);
        appEngine->load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
}

void DefaultTheme::onEvent(QString sender, QString event, QVariant eventData) {
    if(event == "Notification"){
        QJsonDocument doc = QJsonDocument::fromJson(eventData.toString().toUtf8());
        if(!doc.isObject()){
            qDebug() << "Invalid JSON";
            return;
        }
        QJsonObject object = doc.object();
        if(!object.keys().contains("image") || !object.keys().contains("title") || !object.keys().contains("description")){
            qDebug() << "Missing event description";
        }
        emit guiEvents->notificationReceived(object.toVariantMap());
    } else if (event == "OpenOverlay") {
        QVariantMap map = eventData.toMap();

        emit guiEvents->openOverlay(map["source"].toString(), map["properties"].toMap());
    } else if (event == "CloseOverlay") {
        emit guiEvents->closeOverlay();
    }
}

QVariantList DefaultTheme::getMountedVolumes(){
    QVariantList ret;
    for (QStorageInfo storage : QStorageInfo::mountedVolumes()) {
        if (storage.isValid() && storage.isReady()) {
            if (!storage.isReadOnly() && storage.fileSystemType() != "tmpfs" && storage.fileSystemType() != "squashfs") {
                QVariantMap volume;
                volume.insert("name", storage.displayName());
                volume.insert("path",storage.rootPath());
                ret.append(volume);
            }
        }
    }
    return ret;
}
