#ifndef PLUGIN_H
#define PLUGIN_H

#include <QtQml/QQmlExtensionPlugin>
#include <QtQml>
#include "qcdevice.h"
#include "qcstandardpaths.h"

class Plugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.viktorgino.headunit.theme.default" FILE "theme.json")
public:
    void registerTypes(const char * uri) override;
    void initializeEngine(QQmlEngine *engine, const char *uri) override;
};

#endif // PLUGIN_H
