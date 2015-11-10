import QtQuick 2.1
import Sailfish.Silica 1.0

BackgroundItem {
    id: root

    property alias text: label.text
    property real topPadding: Theme.paddingLarge
    property real bottomPadding: 2*Theme.paddingLarge

    implicitHeight: label.height + topPadding + bottomPadding
    width: label.width + 2*Theme.paddingLarge

    Label {
        id: label

        y: topPadding
        anchors.horizontalCenter: parent.horizontalCenter
        color: root.down ? Theme.highlightColor : Theme.primaryColor
        font.pixelSize: Theme.fontSizeMedium
        textFormat: Text.AutoText
    }
}
