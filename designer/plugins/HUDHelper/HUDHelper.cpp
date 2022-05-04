#include <QAbstractItemModel>
#include <QDebug>
#include <QFile>
#include <QQmlEngine>
#include <QQmlExtensionPlugin>
#include <qqml.h>

#include <QFileInfo>
#include <QImage>
#include <QPainter>
#include <qquickimageprovider.h>

class QMapModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QVariantMap model READ getModelData WRITE setModelData NOTIFY modelChanged)
    Q_PROPERTY(int length READ rowCount NOTIFY lengthChanged)
    QML_ELEMENT
public:
    explicit QMapModel(QObject *parent = 0): QAbstractListModel(parent)
    {
        connect(this, &QMapModel::dataChanged, this, &QMapModel::lengthChanged);
    }
    explicit QMapModel(const QMapModel &model)
    {
        qDebug() << "QMapModel move constructor";
    }
    ~QMapModel()
    {
    }
    Q_INVOKABLE QHash<int, QByteArray> roleNames() const override
    {
        QHash<int, QByteArray> ret;
        int i = Qt::UserRole + 1;
        for (QString role : m_roles) {
            ret[i++] = role.toLocal8Bit();
        }
        return ret;
    }
    Q_INVOKABLE int rowCount(const QModelIndex &parent = QModelIndex()) const override
    {
        Q_UNUSED(parent)
        return m_data.size();
    }
    Q_INVOKABLE QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override
    {
        QVariant row = m_data[index.row()];
        int roleId = role - Qt::UserRole - 1;
        if (m_roles.size() > roleId && roleId >= 0) {
            if (row.canConvert(QMetaType::QVariantMap)) {
                QVariantMap rowMap = row.toMap();
                return rowMap[m_roles[roleId]];
            }
            qDebug() << "Data row is not map";
        }
        qDebug() << "Invalid role id";
        return QVariant();
    }
    Q_INVOKABLE void setDataRow(QStringList roles, QVariantList data)
    {
        beginResetModel();
        m_data.clear();
        m_roles.clear();

        m_roles = roles;
        m_data = data;
        endResetModel();
    }

    Q_INVOKABLE void setDataColumn(int row, QString role, QVariant data)
    {
        if (row < m_data.size() && row >= 0) {
            int roleId = m_roles.indexOf(role);
            if (roleId >= 0) {
                QVariantMap rowData = m_data[row].toMap();
                if (!rowData.isEmpty()) {
                    rowData[role] = data;
                    m_data[row] = rowData;
                } else {
                    qDebug() << "Invalid data row map";
                }
            } else {
                qDebug() << "Invalid role";
            }

        } else {
            qDebug() << "Invalid row";
        }
    }

    Q_INVOKABLE QVariantMap getModelData()
    {
        QVariantMap ret;
        ret["data"] = m_data;
        ret["roles"] = m_roles;
        return ret;
    }
    Q_INVOKABLE void remove(int index)
    {
        beginResetModel();
        m_data.removeAt(index);
        endResetModel();
    }
signals:
    void lengthChanged();
    void modelChanged();

private:
    void setModelData(QVariantMap model)
    {
        beginResetModel();
        if (model.contains("data") && model.contains("roles")) {
            QStringList roles;
            if (model["roles"].canConvert(QMetaType::QStringList)) {
            } else {
                qDebug() << "Invalid roles object";
                return;
            }

            QVariantList rolesList = model["roles"].toList();
            for (QVariant role : rolesList) {
                if (role.canConvert(QMetaType::QString)) {
                    roles << role.toString();
                }
            }

            if (!model["data"].canConvert(QMetaType::QVariantList)) {
                qDebug() << "Invalid data object";
                return;
            }

            setDataRow(roles, model["data"].toList());

        } else {
            qDebug() << "Invalida model data object";
        }
        endResetModel();
    }
    QStringList m_roles;
    QVariantList m_data;
};

class IconImageProvider : public QQuickImageProvider
{
public:
    IconImageProvider()
        : QQuickImageProvider(QQuickImageProvider::Pixmap)
    {
    }

    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize) override
    {
        QString iconsFolder = "qml/icons/";
        QString svgFile = iconsFolder + "svg/" + id + ".svg";
        QString pngFile = iconsFolder + id + ".png";

        QString fileName;
        if (QFile::exists(svgFile)) {
            fileName = svgFile;
        } else if (QFile::exists(pngFile)) {
            fileName = pngFile;
        }

        if (fileName.isEmpty()) {
            QPixmap pixmap(requestedSize.width() > 0 ? requestedSize.width() : 1, requestedSize.height() > 0 ? requestedSize.height() : 1);
            pixmap.fill(QColor("#ffffff").rgb());
            return pixmap;
        }

        QImage ret = QImage(fileName);

        *size = ret.size();
        return QPixmap::fromImage(ret);
    }
};

class QMapModelPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID QQmlExtensionInterface_iid)

public:
    void initializeEngine(QQmlEngine *engine, const char *uri) override
    {
        engine->addImageProvider("icons", new IconImageProvider);
    }
    void registerTypes(const char *uri) override
    {
        qmlRegisterType<QMapModel>(uri, 1, 0, "QMapModel");
    }
};

#include "HUDHelper.moc"
