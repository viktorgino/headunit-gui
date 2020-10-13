#include "defaulttheme.h"

DefaultTheme::~DefaultTheme(){

}

void DefaultTheme::registerTypes(const char* /*uri*/)
{

    return;
}

void DefaultTheme::initializeEngine(QQmlEngine *engine, const char* /*uri*/)
{
        QQmlApplicationEngine * appEngine = static_cast<QQmlApplicationEngine* >(engine);
        if(!appEngine){
            qDebug() << "Engine is not a valid instance of QQmlApplicationEngine";
            return;
        }
        guiEvents = new GUIEvents();
        appEngine->addImportPath("themes/default-theme");
        appEngine->rootContext()->setContextProperty("GUIEvents", guiEvents);
        appEngine->load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
}

void DefaultTheme::onEvent(QString event, QString eventData) {
    QJsonDocument doc = QJsonDocument::fromJson(eventData.toUtf8());
    if(!doc.isObject()){
        qDebug() << "Invalid JSON";
        return;
    }
    QJsonObject object = doc.object();
    if(event == "Notification"){
        if(!object.keys().contains("image") || !object.keys().contains("title") || !object.keys().contains("description")){
            qDebug() << "Missing event description";
        }
        emit guiEvents->notificationReceived(object.toVariantMap());
    } else if (event == "Overlay") {

    }
}
