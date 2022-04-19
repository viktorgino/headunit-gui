#ifndef THEMEICONPROVIDER_H
#define THEMEICONPROVIDER_H

#include <QAbstractItemModel>
#include <QDebug>
#include <QQmlEngine>
#include <QFile>
#include <QQmlExtensionPlugin>
#include <qqml.h>

#include <qquickimageprovider.h>
#include <QImage>
#include <QPainter>
#include <QFileInfo>

class ThemeIconProvider : public QQuickImageProvider
{
public:
    ThemeIconProvider();

    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize) override;
};

#endif // THEMEICONPROVIDER_H
