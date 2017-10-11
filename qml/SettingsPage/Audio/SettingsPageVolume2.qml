import QtQuick 2.2
import QtQuick.Layouts 1.0

import org.kde.plasma.private.volume 0.1

Item {
    id: main

    property bool volumeFeedback: true
    property int maxVolumeValue: Math.round(100 * PulseAudio.NormalVolume / 100.0)
    property int volumeStep: Math.round(1 * PulseAudio.NormalVolume / 100.0)
    property string displayName: i18n("Audio Volume")
    property QtObject draggedStream: null

    Layout.minimumHeight: units.gridUnit * 12
    Layout.minimumWidth: units.gridUnit * 12
    Layout.preferredHeight: units.gridUnit * 20
    Layout.preferredWidth: units.gridUnit * 20

    function boundVolume(volume) {
        return Math.max(PulseAudio.MinimalVolume, Math.min(volume, maxVolumeValue));
    }

    function volumePercent(volume, max) {
        if (!max) {
            max = PulseAudio.NormalVolume;
        }
        return Math.round(volume / max * 100.0);
    }

    function increaseVolume() {
        if (!sinkModel.preferredSink) {
            return;
        }
        var volume = boundVolume(sinkModel.preferredSink.volume + volumeStep);
        var percent = volumePercent(volume, maxVolumeValue);
        sinkModel.preferredSink.muted = percent == 0;
        sinkModel.preferredSink.volume = volume;
        osd.show(percent);
        playFeedback();
    }

    function decreaseVolume() {
        if (!sinkModel.preferredSink) {
            return;
        }
        var volume = boundVolume(sinkModel.preferredSink.volume - volumeStep);
        var percent = volumePercent(volume, maxVolumeValue);
        sinkModel.preferredSink.muted = percent == 0;
        sinkModel.preferredSink.volume = volume;
        osd.show(percent);
        playFeedback();
    }

    function muteVolume() {
        if (!sinkModel.preferredSink) {
            return;
        }
        var toMute = !sinkModel.preferredSink.muted;
        sinkModel.preferredSink.muted = toMute;
        osd.show(toMute ? 0 : volumePercent(sinkModel.preferredSink.volume, maxVolumeValue));
        playFeedback();
    }

    function increaseMicrophoneVolume() {
        if (!sourceModel.defaultSource) {
            return;
        }
        var volume = boundVolume(sourceModel.defaultSource.volume + volumeStep);
        var percent = volumePercent(volume);
        sourceModel.defaultSource.muted = percent == 0;
        sourceModel.defaultSource.volume = volume;
        osd.showMicrophone(percent);
    }

    function decreaseMicrophoneVolume() {
        if (!sourceModel.defaultSource) {
            return;
        }
        var volume = boundVolume(sourceModel.defaultSource.volume - volumeStep);
        var percent = volumePercent(volume);
        sourceModel.defaultSource.muted = percent == 0;
        sourceModel.defaultSource.volume = volume;
        osd.showMicrophone(percent);
    }

    function muteMicrophone() {
        if (!sourceModel.defaultSource) {
            return;
        }
        var toMute = !sourceModel.defaultSource.muted;
        sourceModel.defaultSource.muted = toMute;
        osd.showMicrophone(toMute? 0 : volumePercent(sourceModel.defaultSource.volume));
    }

    function beginMoveStream(type, stream) {
        if (type == "sink") {
            sourceView.visible = false;
            sourceViewHeader.visible = false;
        } else if (type == "source") {
            sinkView.visible = false;
            sinkViewHeader.visible = false;
        }

        tabBar.currentTab = devicesTab;
    }

    function endMoveStream() {
        tabBar.currentTab = streamsTab;

        sourceView.visible = true;
        sourceViewHeader.visible = true;
        sinkView.visible = true;
        sinkViewHeader.visible = true;
    }

    function playFeedback(sinkIndex) {
        if (!volumeFeedback) {
            return;
        }
        if (sinkIndex == undefined) {
            sinkIndex = sinkModel.preferredSink.index;
        }
        feedback.play(sinkIndex);
    }



    VolumeOSD {
        id: osd
    }

    VolumeFeedback {
        id: feedback
    }
    ColumnLayout {
        id: devicesView
        width: parent.width

        Header {
            id: sinkViewHeader
            Layout.fillWidth: true
            visible: sinkView.count > 0
            text: i18n("Playback Devices")
        }
        ListView {
            id: sinkView

            Layout.fillWidth: true
            Layout.minimumHeight: contentHeight
            Layout.maximumHeight: contentHeight

            model: PulseObjectFilterModel {
                sortRole: "SortByDefault"
                sortOrder: Qt.DescendingOrder
                sourceModel: SinkModel {
                    id: sinkModel
                }
            }
            boundsBehavior: Flickable.StopAtBounds;
            delegate: DeviceListItem {
                type: "sink"
            }
        }

        Header {
            id: sourceViewHeader
            Layout.fillWidth: true
            visible: sourceView.count > 0
            text: i18n("Capture Devices")
        }
        ListView {
            id: sourceView

            Layout.fillWidth: true
            Layout.minimumHeight: contentHeight
            Layout.maximumHeight: contentHeight

            model: PulseObjectFilterModel {
                sortRole: "SortByDefault"
                sortOrder: Qt.DescendingOrder
                sourceModel: SourceModel {
                    id: sourceModel
                }
            }
            boundsBehavior: Flickable.StopAtBounds;
            delegate: DeviceListItem {
                type: "source"
            }
        }

        Header {
            Layout.fillWidth: true
            visible: sinkInputView.count > 0
            text: i18n("Playback Streams")
        }
        ListView {
            id: sinkInputView

            Layout.fillWidth: true
            Layout.minimumHeight: contentHeight
            Layout.maximumHeight: contentHeight

            model: PulseObjectFilterModel {
                filters: [ { role: "VirtualStream", value: false } ]
                sourceModel: SinkInputModel {}
            }
            boundsBehavior: Flickable.StopAtBounds;
            delegate: StreamListItem {
                type: "sink-input"
                draggable: sinkView.count > 1
            }
        }

        Header {
            Layout.fillWidth: true
            visible: sourceOutputView.count > 0
            text: i18n("Capture Streams")
        }
        ListView {
            id: sourceOutputView

            Layout.fillWidth: true
            Layout.minimumHeight: contentHeight
            Layout.maximumHeight: contentHeight

            model: PulseObjectFilterModel {
                filters: [ { role: "VirtualStream", value: false } ]
                sourceModel: SourceOutputModel {}
            }
            boundsBehavior: Flickable.StopAtBounds;
            delegate: StreamListItem {
                type: "source-input"
                draggable: sourceView.count > 1
            }
        }
    }
}
