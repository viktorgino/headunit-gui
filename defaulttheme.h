#ifndef DEFAULTTHEME_H
#define DEFAULTTHEME_H

#include <QObject>
#include <QtQml/QQmlExtensionPlugin>
#include <QtQml>
#include <QQuickStyle>
#include <QStorageInfo>
#include "themeiconprovider.h"
#include <abstractplugin.h>

class GUIEvents : public QObject {
    Q_OBJECT
signals:
    void notificationReceived(QVariantMap notification);
    void openOverlay(QVariant settings, QObject *contextProperty, QString source, QVariantMap properties);
    void closeOverlay();
    void changePageNext();
    void changePagePrev();
    void changePageIndex(qint32 index);
    void changePagePrevIndex();
};

class DefaultTheme : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.viktorgino.headunit.theme.default" FILE "theme.json")
    ~DefaultTheme() override;
public:
    void registerTypes(const char * uri) override;
    void initializeEngine(QQmlEngine *engine, const char *uri) override;

    Q_INVOKABLE QVariantList getMountedVolumes();
public slots:
    void onEvent(AbstractPlugin* plugin, QString sender, QString event, QVariant eventData);
private:
    GUIEvents *guiEvents;
};

#endif // DEFAULTTHEME_H
