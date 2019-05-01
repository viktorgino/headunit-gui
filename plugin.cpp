#include "plugin.h"

static QObject *standardPathsProvider(QQmlEngine *engine, QJSEngine *scriptEngine) {
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);

    QCStandardPaths* object = new QCStandardPaths();

    return object;
}

void Plugin::registerTypes(const char* /*uri*/)
{
    qmlRegisterSingletonType<QCDevice>("QuickCross", 1, 0,
                                       "StandardPaths", standardPathsProvider);
    return;
}

void Plugin::initializeEngine(QQmlEngine *engine, const char* /*uri*/)
{
        QQmlApplicationEngine * appEngine = static_cast<QQmlApplicationEngine* >(engine);
        if(!appEngine){
            qDebug() << "Engine is not a valid instance of QQmlApplicationEngine";
            return;
        }
        appEngine->addImportPath("themes/default-theme");
        appEngine->load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
}
