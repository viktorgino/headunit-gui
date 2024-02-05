import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQml.Models 2.15

ListModel {
    id: root
    property string listType: ""
    property QtObject plugins
    onPluginsChanged: {
        for (var i = 0; i < plugins.length; i++) {
            root.append(plugins[i])
        }
    }
} //NameRole = Qt::UserRole + 1,//LabelRole,//IconRole,//QmlSourceRole,//LoadedRole,//SettingsRole,//SettingsItemsRole
