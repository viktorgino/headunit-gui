#include "themeiconprovider.h"

ThemeIconProvider::ThemeIconProvider() : QQuickImageProvider(QQuickImageProvider::Pixmap){

}

QPixmap ThemeIconProvider::requestPixmap(const QString &id, QSize *size, const QSize &requestedSize){
    QString iconsFolder = ":/qml/icons/";
    QString svgFile = iconsFolder + "svg/" + id + ".svg";
    QString pngFile = iconsFolder + id + ".png";

    QString fileName;
    if(QFile::exists(svgFile)) {
        fileName = svgFile;
    } else if (QFile::exists(pngFile)){
        fileName = pngFile;
    }

    if(fileName.isEmpty()){
        QPixmap pixmap(requestedSize.width() > 0 ? requestedSize.width() : 1,
                       requestedSize.height() > 0 ? requestedSize.height() : 1);
        pixmap.fill(QColor("#ffffff").rgb());
        return pixmap;
    }

    QImage ret = QImage(fileName);

    *size = ret.size();
    return QPixmap::fromImage(ret);
}
