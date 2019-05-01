#ifndef DEFAULTTHEME_H
#define DEFAULTTHEME_H

#include <QObject>
#include <QtQml/QQmlExtensionPlugin>
#include <QtQml>
#include "qcdevice.h"
#include "qcstandardpaths.h"

class GUIEvents : public QObject {
    Q_OBJECT
signals:
    void notificationReceived(QVariantMap notification);
};

class DefaultTheme : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.viktorgino.headunit.theme.default" FILE "theme.json")
    ~DefaultTheme() override;
public:
    void registerTypes(const char * uri) override;
    void initializeEngine(QQmlEngine *engine, const char *uri) override;
public slots:
    void onEvent(QString event, QString eventData);
private:
    GUIEvents *guiEvents;
    static QObject *standardPathsProvider(QQmlEngine *engine, QJSEngine *scriptEngine);
};

#endif // DEFAULTTHEME_H
